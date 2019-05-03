# Realtime priority settings (rtprio)

If you see the following message when starting an image (and it bothers you)

```plaintext
pthread_setschedparam failed: Operation not permitted
This VM uses a separate heartbeat thread to update its internal clock
and handle events.  For best operation, this thread should run at a
higher priority, however the VM was unable to change the priority.  The
effect is that heavily loaded systems may experience some latency
issues.  If this occurs, please create the appropriate configuration
file in /etc/security/limits.d/ as shown below:

cat <<END | sudo tee /etc/security/limits.d/pharo.conf
*      hard    rtprio  2
*      soft    rtprio  2
END

and report to the pharo mailing list whether this improves behaviour.

You will need to log out and log back in for the limits to take effect.
For more information please see
https://github.com/OpenSmalltalk/opensmalltalk-vm/releases/tag/r3732#linux
```

Depending on how are you running the image, you have a variety of solutions:

## Plain docker

If running using `docker run` you can set it using:
`docker run --ulimit rtprio=2:2 ...`

## docker-compose

If running with `docker-compose` you can configure it on the _docker-compose.yml_ file with:

```yaml
services:
  my-pharo-service:
    ulimits:
      rtprio:
        soft: 2
        hard: 2
```

## docker-swarm

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

The swarm mode solution should work for all cases.
But it's global for every container, and you might not like that.