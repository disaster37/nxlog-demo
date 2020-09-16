NXLog Enterprise Edition is an advanced, modular, multi-threaded,
high-performance log management solution.

NXLog Docker version is based on the latest CentOS 7 base image. During the
docker build process the centosplus and epel 3rd party repos are enabled.

The build process uses the NXLog RHEL 7 version and installs all modules
available on RHEL 7.

GETTING STARTED

Build the standalone version with `docker build -t nxlog .`

You can also build a version to connect with NXLog Manager. First, place the
exported *CA Certificate* in *PEM* format from the running NXLog Manager as
**agent-ca.pem**. Then, run the build command:
`docker build -t nxlog --build-arg NXLOG_MANAGER=<NXLOG-MANAGER-IP> .`

Start the container with: `docker run -p <HostPort>:<ContainerPort> -d nxlog`.

EDIT CONFIGURATION

Custom configuration files with *conf* extension are copied to the
`/opt/nxlog/etc` folder at build time.

The default configuration file can be overridden with `-c <PATH-TO-CONFIG>` when
starting the container.

Ports can be opened with `-p <HostPort>:<ContainerPort>` when starting the
container.

For more information refer to the docker run documentation at
<https://docs.docker.com/engine/reference/commandline/run/>.

INTERNAL LOG DATA

By default, NXLog will write its own messages to the log file at
`/opt/nxlog/var/log/nxlog/nxlog.log`. If you have trouble starting or running
NXLog, check that file for errors.

LEARN MORE

For details about configuration and usage, see the NXLog Reference Manual
in the `doc` directory as a PDF
(`/opt/nxlog/share/doc/nxlog/nxlog-reference-manual.pdf`) and as HTML
(`/opt/nxlog/share/doc/nxlog/nxlog-reference-manual.html`).

The NXLog User Guide is also available online at
<https://nxlog.co/documentation/nxlog-user-guide>.
There you will also find the Reference Manual at
<https://nxlog.co/documentation/nxlog-user-guide/ref>,
the NXLog Manager User Guide at
<https://nxlog.co/documentation/nxlog-user-guide/nxlog-manager.html>,
and the NXLog Add-Ons reference at
<https://nxlog.co/documentation/nxlog-user-guide/addons.html>.

Thank you for choosing NXLog!
