# Docker-Pharo (Legacy)

**Since Pharo 10, docker images are split in an image containing the [VM](https://github.com/ba-st/docker-pharo-vm)
and another one containing also the [Pharo Image](https://github.com/ba-st/docker-pharo-runtime).**

**This project is no longer receiving udpates**

---

[![Build Status](https://travis-ci.org/ba-st/docker-pharo.svg?branch=master)](https://travis-ci.org/ba-st/docker-pharo)

Docker image for pharo [basmalltalk/pharo](https://hub.docker.com/r/basmalltalk/pharo/)

The Pharo VM is in _/opt/pharo_, under user `pharo (7431)`, group `users (100)`

## Useful stuff

- [How to](docs/rtprio.md) deal with `pthread_setschedparam failed: Operation not permitted`
- [Examples](docs/Examples.md) of Dockerfiles and docker-compose.yml
