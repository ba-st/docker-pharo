# Docker-Pharo

Docker image for pharo [basmalltalk/docker-pharo](https://hub.docker.com/r/basmalltalk/docker-pharo/)

The Pharo VM is in _/opt/pharo_, under user `pharo`

The user UID and group GID can be customized on build, default to 7431.

## Realtime priority settings (rtprio)

If running using `docker run` you can set it using:
`docker run --ulimit rtprio=2:2 ...`

If running under swarm mode, you need to configure it on the docker daemon, on
_/etc/docker/daemon.json_ with the following configuration.

```json
{
  "default-ulimits": {
    "rtprio": {
      "Name": "rtprio",
      "Hard": 2,
      "Soft": 2
    }
  }
}
```
