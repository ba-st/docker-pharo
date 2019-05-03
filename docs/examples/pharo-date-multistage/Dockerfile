# Build in 2 stages to minimize the size of the final docker image
# See https://docs.docker.com/develop/develop-images/multistage-build/

# Stage 1: Load the project
FROM basmalltalk/pharo:6.1-image AS loader
COPY load-project.st ./
RUN ./pharo Pharo.image load-project.st --save --quit

# Stage 2: Copy the resulting Pharo.image with our project loaded
# into a new docker image with just the vm
FROM basmalltalk/pharo:6.1
WORKDIR /opt/pharo/
COPY --from=loader --chown=pharo /opt/pharo/Pharo.image ./
COPY --from=loader --chown=pharo /opt/pharo/Pharo.changes ./
COPY start.st ./

CMD [ "/opt/pharo/pharo", "Pharo.image", "start.st" ]
