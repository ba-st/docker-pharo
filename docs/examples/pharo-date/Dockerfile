# Use the images generated from this repository as base
FROM basmalltalk/pharo:7.0-image

# Put the load-project.st script in the docker image and then load the project
COPY load-project.st ./
RUN pharo Pharo.image load-project.st --save --quit

# Put start.st in the docker image and configure the docker image to start it
COPY start.st ./
CMD [ "pharo", "Pharo.image", "start.st" ]
