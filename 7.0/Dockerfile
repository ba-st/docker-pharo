FROM alpine as download
WORKDIR /opt/pharo
RUN set -eu; \
	apk add --update curl unzip bash && curl get.pharo.org/64/vm70 | bash; \
	sed --regexp-extended --in-place 's/--nodisplay/-vm-sound-null -vm-display-null/' pharo; \
	rm -rf \
		pharo-ui \
		pharo-vm/lib/pharo/*/__MACOSX/ \
		pharo-vm/lib/pharo/*/*.a \
		pharo-vm/lib/pharo/*/vm-display-X11.* \
		pharo-vm/lib/pharo/*/vm-display-fbdev.* \
		pharo-vm/lib/pharo/*/vm-sound-ALSA.* \
		pharo-vm/lib/pharo/*/vm-sound-NAS.* \
		pharo-vm/lib/pharo/*/vm-sound-OSS.* \
		pharo-vm/lib/pharo/*/vm-sound-pulse.* \
		; \
	chmod -R 775 pharo pharo-vm

FROM debian:9-slim
LABEL maintainer="serpi90@gmail.com"

# By default use an arbitrary userid and groupid of the pharo user
ARG PHARO_UID=7431
ARG PHARO_GID=7431

RUN set -eu; \
	apt-get update; \
	apt-get --assume-yes --no-install-recommends install \
		ca-certificates \
		libcurl3-gnutls \
		libfreetype6 \
		libstdc++6 \
		; \
	apt-get clean; \
	rm --recursive --force /var/lib/apt/lists/* /tmp/* /var/tmp/*; \
	groupadd --gid $PHARO_GID pharo; \
	useradd --uid $PHARO_UID --gid $PHARO_GID --home-dir /opt/pharo --no-create-home --no-user-group pharo

COPY --from=download --chown=pharo:pharo /opt/pharo /opt/pharo
WORKDIR /opt/pharo
USER pharo
