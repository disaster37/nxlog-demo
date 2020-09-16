# NXLog docker version

## NOTE
* NXLog docker version is based on the latest CentOS 7 base image.
* During the docker build process the centosplus and epel 3rd party repos are enabled.
* The build process uses the NXLog RHEL 7 version and installs all modules available on RHEL 7.

## Build a standalone version

* Build command: `docker build -t nxlog .`

## Build a version connecting to a NXLog Manager

* Place the exported *CA Certificate* in *PEM* format from the running NXLog Manager as **agent-ca.pem**
* Build command: `docker build -t nxlog --build-arg NXLOG_MANAGER=<NXLOG-MANAGER-IP> .`

## Run the NXLog Agent

* Start the container: `docker run -p <HostPort>:<ContainerPort> -d nxlog`

## Customization

* Custom configuration files with *conf* extension are copied to the `/opt/nxlog/etc` folder at build time.
* The default configuration file can be overriden with `-c <PATH-TO-CONFIG>` when starting the container.
* Ports can be opened with `-p <HostPort>:<ContainerPort>` when starting the container.
* For more information refer to the [docker create](https://docs.docker.com/engine/reference/commandline/run/) documentation.
