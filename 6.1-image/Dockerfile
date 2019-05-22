FROM alpine as download

RUN apk add --update unzip

WORKDIR /opt/pharo

ADD http://files.pharo.org/get-files/61/pharo-linux-stable.zip .
ADD http://files.pharo.org/get-files/61/sources.zip .

RUN set -eux; \
  unzip pharo-linux-stable.zip; \
  unzip sources.zip; \
  true
RUN set -eux; \
  mv lib/pharo/*/ vm/; \
  mv *.sources vm/; \
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

ADD http://files.pharo.org/get-files/61/pharo.zip .
RUN set -eux; \
  mkdir images; \
  unzip pharo.zip -d images; \
  true

FROM debian:9-slim
LABEL maintainer="serpi90@gmail.com"
WORKDIR /opt/pharo
RUN set -eux; \
  dpkg --add-architecture i386; \
  apt-get update; \
  apt-get install --assume-yes --no-install-recommends \
    ca-certificates \
    libcurl3-gnutls:i386 \
    libfreetype6:i386 \
    libstdc++6:i386 \
    ; \
  apt-get clean; \
  groupadd --gid 7431 pharo; \
  useradd --uid 7431 --gid 7431 --home-dir /opt/pharo --no-create-home --no-user-group pharo; \
  rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*; \
  echo '/opt/pharo/vm/pharo -vm-sound-null -vm-display-null "$@"' > /usr/local/bin/pharo; \
  chmod a+x /usr/local/bin/pharo; \
  mkdir vm; \
  true

COPY --from=download --chown=pharo:pharo /opt/pharo/vm /opt/pharo/images /opt/pharo/

USER pharo
