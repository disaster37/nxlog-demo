FROM centos:7

LABEL maintainer="info@nxlog.org"
LABEL vendor="NXLog Ltd"

# build-time argument
ARG NXLOG_MANAGER=nomanager
ARG http_proxy
ARG https_proxy

# Set the working directory to /opt
WORKDIR /opt

# Copy nxlog packages and agent-ca.pem if any, and custom configurations if any
COPY nxlog-*.tar.bz2 agent-ca.* *.conf readme.txt /opt/

# Enable needed repos (centosplus and epel) and update
RUN yum-config-manager --enable centosplus && \
yum install -y epel-release bzip2 && \
yum-config-manager --enable epel && \
yum update -y

# Extract the .tar.bz2 package on the container at /opt
RUN tar -xjf nxlog-*.tar.bz2

# install nxlog and skip not available dependencies
RUN yum install -y --skip-broken nxlog-*.rpm

# Replace default rpm readme.txt with docker-specific one
RUN mv readme.txt /opt/nxlog/share/doc/nxlog/

# Set up NXLog Manager connection and cert
RUN if [[ "${NXLOG_MANAGER}" == "nomanager" ]]; \
then sed -i 's/^include/\#include/g' /opt/nxlog/etc/nxlog.conf && \
sed -i 's/^\#LogFile/LogFile/g' /opt/nxlog/etc/nxlog.conf; \
else sed -i "s/192.168.1.1/$NXLOG_MANAGER/g" /opt/nxlog/var/lib/nxlog/log4ensics.conf && \
mv agent-ca.pem /opt/nxlog/var/lib/nxlog/cert/agent-ca.pem && \
chown nxlog:nxlog /opt/nxlog/var/lib/nxlog/cert/agent-ca.pem && \
chmod 660 /opt/nxlog/var/lib/nxlog/cert/agent-ca.pem; \
fi

# Copy custom config if any
RUN find /opt -maxdepth 1 -type f -name \*.conf -exec cp -f {} /opt/nxlog/etc \;

# yum and workdir cleanup
RUN yum clean all && \
rm -rf /var/cache/yum && \
rm -f nxlog-*.rpm && \
rm -f nxlog-*.tar.bz2 && \
rm -f *.conf && \
rm -f agent-ca.*

# Start nxlog
USER nxlog
ENTRYPOINT [ "/opt/nxlog/bin/nxlog", "-f" ]
CMD [ "-c", "/opt/nxlog/etc/nxlog.conf" ]
