PyLoad
=========

[![Build and Publish](https://github.com/anarion80/docker-pyload-ng/actions/workflows/build-and-publish.yml/badge.svg)](https://github.com/anarion80/docker-pyload-ng/actions/workflows/build-and-publish.yml)

**NOTICE**: If pyload is not able to update plugins, try to use `latest` tag

Introduction
----

pyLoad is a fast, lightweight and full featured download manager for many One-Click-Hoster, container formats like DLC, video sites or just plain http/ftp links. It aims for low hardware requirements and platform independence to be runnable on all kind of systems (desktop pc, netbook, NAS, router).

Despite its strict restriction it is packed full of features just like webinterface, captcha recognition, unrar and much more.

pyLoad is divided into core and clients, to make it easily remote accessible. Currently there are a webinterface, command line interface, and a GUI written in Qt.

Source [official pyload](https://pyload.net/).

Install
----

Install is easy as all docker images

```sh
docker pull anarion80/pyload-ng:latest
```

Running
----

```sh
docker run -d -P anarion80/pyload-ng:latest
```

Configuration
----

You can link your Downloads to your host very easy like that:

```sh
docker run -d -v <host directoy>:/downloads -P anarion80/pyload-ng:latest
```

Notice to replace ```<host directory>``` with your directory path on the host. So if you want to store your Downloads in ```/tmp/Downloads``` then your command would look like this:

```sh
docker run -d -v /tmp/Downloads:/downloads -P anarion80/pyload-ng:latest
```

If you want to have your configuration persistent you have to link the configuration directory outside of the container. This can happen like this:

```sh
docker run -d -v <host directoy>:/config -P anarion80/pyload-ng:latest
```

By default, pyload will be run as root, and will download files with uid 0 and gid 0. If you want to change this behavior, you can specify the PUID and PGID that will be used for the downloaded files by using ENV VARS

Docker run command
-----

```sh
docker \
    run \
    -d \
    -v <host download directory>:/downloads \
    -v <host config directoy>:/config \
    -e PUID=<uid> \
    -e PGID=<gid> \
    -P \
    anarion80/pyload-ng:latest
```

Sample compose file
-----

```yaml
version: "2"
services:
    pyload:
      image: anarion80/pyload-ng:latest
      container_name: pyload
      ports:
        - 8000:8000
      environment:
        - PUID=1000
        - PGID=1000
      volumes:
        - /path/to/config:/config
        - /path/to/data:/downloads

```

Finally
----

When the container has been created you can login via the webinterface at **\<host-ip>:8000** with:

```sh
USER=pyload
PASSWORD=pyload
```
