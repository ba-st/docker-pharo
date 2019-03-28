FROM debian:9-slim

LABEL maintainer="serpi90@gmail.com"

# By default use an arbitrary userid and groupid of the pharo user
ARG PHARO_UID=7431
ARG PHARO_GID=7431

WORKDIR /opt/pharo

# Install library dependencies
# Install pharo-vm
# Remove unwanted stuff (On a headless container display and sound plugins should not be required)
# Create pharo user
# Cleanup
RUN dpkg --add-architecture i386 \
  && apt-get update \
  && apt-get --assume-yes --no-install-recommends install \
    curl \
    unzip \
    ca-certificates \
    libfreetype6:i386 \
    libstdc++6:i386 \
  && curl get.pharo.org/61+vm | bash \
  && sed --regexp-extended --in-place 's/--nodisplay/-vm-sound-null -vm-display-null/' pharo \
  && rm --recursive --force \
    pharo-ui \
    pharo-vm/lib/pharo/*/__MACOSX/ \
    pharo-vm/lib/pharo/*/vm-display-{fbdev,X11}.* \
    pharo-vm/lib/pharo/*/vm-sound-{ALSA,NAS,OSS,pulse}.* \
  && groupadd --gid $PHARO_GID pharo \
  && useradd --uid $PHARO_UID --gid $PHARO_GID --home-dir /opt/pharo --no-create-home --no-user-group pharo \
  && chown --recursive pharo:pharo /opt/pharo \
  && chmod --recursive 775 pharo pharo-vm \
  && apt-get --assume-yes --auto-remove purge unzip curl \
  && apt-get clean \
  && rm --recursive --force /var/lib/apt/lists/* /tmp/* /var/tmp/* 

USER pharo
