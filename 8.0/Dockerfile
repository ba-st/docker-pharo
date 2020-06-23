# Prepare a base image to use docker cache during build
FROM debian:10-slim as base
LABEL maintainer="serpi90@gmail.com"
WORKDIR /opt/pharo
# hadolint ignore=DL3008
RUN set -eu; \
  apt-get update; \
  apt-get install --assume-yes --no-install-recommends \
    ca-certificates \
    libcurl3-gnutls \
    libfreetype6 \
    libstdc++6 \
    ; \
  apt-get clean; \
  useradd --uid 7431 --gid 100 --home-dir /opt/pharo --no-create-home --no-user-group pharo; \
  rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*; \
  printf '#!/bin/bash\n/opt/pharo/vm/pharo -vm-sound-null -vm-display-null "$@"' > /opt/pharo/pharo; \
  ln -s /opt/pharo/pharo /usr/local/bin/pharo; \
  chmod a+x /usr/local/bin/pharo; \
  chown 7431:100 /opt/pharo -R; \
  true


# Download pharo vm and remove unwanted stuff
FROM alpine:3.12 as download-vm
WORKDIR /opt/pharo
ADD http://files.pharo.org/get-files/80/pharo64-linux-stable.zip ./
RUN unzip pharo64-linux-stable.zip
RUN set -eu; \
  mv lib/pharo/*/ vm/; \
  rm -rf \
    vm/__MACOSX/ \
    vm/*.a \
    vm/vm-display-X11.* \
    vm/vm-display-fbdev.* \
    vm/vm-sound-ALSA.* \
    vm/vm-sound-NAS.* \
    vm/vm-sound-OSS.* \
    vm/vm-sound-pulse.* \
    ; \
  true


# Copy vm into base image
FROM base as vm
COPY --from=download-vm --chown=pharo:users /opt/pharo/vm /opt/pharo/vm
USER pharo


# Download pharo image
FROM download-vm as download-image
WORKDIR /opt/pharo/images
ADD http://files.pharo.org/get-files/80/pharo64.zip ./
RUN set -eu; \
  unzip pharo64.zip; \
  rm pharo64.zip; \
  mv ./*.image Pharo.image; \
  mv ./*.changes Pharo.changes; \
  true


# Copy image into vm image
FROM vm as image
COPY --from=download-image --chown=pharo:users /opt/pharo/images /opt/pharo/
RUN chmod a+w /opt/pharo
USER pharo
