# Prepare a base image to use docker cache during build
FROM debian:9-slim as base
LABEL maintainer="serpi90@gmail.com"

WORKDIR /opt/pharo
RUN set -eu; \
  apt-get update; \
  apt-get install --assume-yes --no-install-recommends \
    ca-certificates \
    libcurl3-gnutls \
    libfreetype6 \
    libstdc++6 \
    ; \
  apt-get clean; \
  groupadd --gid 7431 pharo; \
  useradd --uid 7431 --gid 7431 --home-dir /opt/pharo --no-create-home --no-user-group pharo; \
  rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*; \
  echo '#!/bin/bash\n/opt/pharo/vm/pharo -vm-sound-null -vm-display-null "$@"' > /opt/pharo/pharo; \
  ln -s /opt/pharo/pharo /usr/local/bin/pharo; \
  chmod a+x /usr/local/bin/pharo; \
    chown 7431:7431 /opt/pharo -R; \
  true


# Download pharo vm and remove unwanted stuff
FROM alpine as download-vm
RUN apk add --update unzip
WORKDIR /opt/pharo
ADD http://files.pharo.org/get-files/70/pharo64-linux-stable.zip .
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
COPY --from=download-vm --chown=pharo:pharo /opt/pharo/vm /opt/pharo/vm
USER pharo


# Download pharo image
FROM download-vm as download-image
ADD http://files.pharo.org/get-files/70/pharo64.zip .
RUN set -eu; \
  mkdir images; \
  unzip pharo64.zip -d images; \
  cd images; \
  mv *.image Pharo.image; \
  mv *.changes Pharo.changes; \
  true


# Copy image into vm image
FROM vm as image
COPY --from=download-image --chown=pharo:pharo /opt/pharo/images /opt/pharo/
RUN chmod a+w /opt/pharo
USER pharo
