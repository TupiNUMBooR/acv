FROM alpine

RUN apk update && \
    apk upgrade && \
    apk add \
  bash bash-completion \
  curl zip p7zip ncdu perl jq \
  exiv2 imagemagick ffmpeg

COPY acv /acv/
RUN chown -R 1000:1000 acv

USER 1000
ENTRYPOINT /acv/acv.sh
WORKDIR /acv
#ENTRYPOINT /usr/bin/env bash
