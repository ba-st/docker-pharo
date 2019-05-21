FROM alpine as download
LABEL maintainer="serpi90@gmail.com"
WORKDIR /opt/pharo
RUN apk add --update bash curl unzip && curl get.pharo.org/64/70 | bash

FROM basmalltalk/pharo:7.0
LABEL maintainer="serpi90@gmail.com"
WORKDIR /opt/pharo
USER pharo
COPY --from=download --chown=pharo:pharo \
	/opt/pharo/Pharo.image \
	/opt/pharo/Pharo.changes \
	/opt/pharo/*.sources \
	./
