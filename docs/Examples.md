# Examples

Some Dockerfiles and docker-compose.yml examples for common use cases.

## [pharo-date](examples/pharo-date)

It's a simple web service which listens on port 8080
and responds to `GET` requets with the current `DateAndTime now printString`.

To build it, inside the [examples/pharo-date](examples/pharo-date) folder run:

```bash
docker build . -t pharo-date
```

To run it (use `CTRL + C` to stop it):

```bash
docker run --interactive --tty --rm --publish 8080:8080 pharo-date
```

## [pharo-date.multistage](examples/pharo-date.multistage)

Same as **pharo-date** but using a [multistage build](https://docs.docker.com/develop/develop-images/multistage-build/) which reduces the final docker image size. (222MB -> 176MB at the time of writing)

It's built and run in the same way as _pharo-date_ but inside the [pharo-date.multistage](examples/pharo-date.multistage) folder.

## [balanced-pharo-date](examples/balanced-pharo-date)

An example of a balanced service using [Traefik](https://docs.traefik.io/) as a load balancer, to be run using `docker-compose` (on a single machine)

- The file [docker-compose.yml](examples/balanced-pharo-date/docker-compose.yml) describes which services to run, which files to mount, and some other configuration.
- The file [traefik.toml](examples/balanced-pharo-date/traefik.toml) is the traefik configuration file.

For more information see the [Traefik docker docs](https://docs.traefik.io/configuration/backends/docker/)

To run this, first build the pharo-date image as described above, and then on the [balanced-pharo-date](examples/balanced-pharo-date) folder run

```bash
docker-compose up
```

That will set up a single container behind the balancer

To set up more you can do

```bash
docker-compose up --scale date=3
```

## [balanced-pharo-date-swarm](examples/balanced-pharo-date-swarm)

If you don't know what a swarm is,
or don't have a swarm up and running,
please skip this section.

Similar to balanced-pharo-date but running on a docker swarm, provided because the configuration for traefik differs.

To start it up.

```bash
docker stack deploy --compose-file=docker-compose.yml pharo-date
```

To stop it

```bash
docker stack rm pharo-date
```