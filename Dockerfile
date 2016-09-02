# Tor exit relay

FROM alpine:latest

MAINTAINER Ben Mezger

RUN apk update && apk add tor --update-cache \
    --repository http://dl-3.alpinelinux.org/alpine/edge/testing/

RUN rm -rf /var/cache/apk/*
RUN systemctl stop tor # stop tor in case it starts to run

COPY torrc.exit /etc/tor/torrc.exit

# make sure files are owned by tor
RUN chown -R tor /etc/tor

USER tor
# default port for incoming Tor connections
EXPOSE 9001

ENTRYPOINT ["tor"]
