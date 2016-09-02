# Tor exit relay

FROM alpine:latest

MAINTAINER Ben Mezger

RUN apk update && apk add tor --update-cache \
    --repository http://dl-3.alpinelinux.org/alpine/edge/community/

RUN rm -rf /var/cache/apk/*

COPY torrc.exit /etc/tor/torrc.exit
COPY tor-exit-notice.html /etc/tor/tor-exit-notice.html

# make sure files are owned by tor
RUN chown -R tor /etc/tor

USER tor
# default port for incoming Tor connections
EXPOSE 9001

ENTRYPOINT ["tor"]
