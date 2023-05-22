FROM alpine:3.18

LABEL org.opencontainers.image.source https://github.com/hairyhenderson/dockerfiles

RUN apk add --no-cache \
  ca-certificates \
  socat

ENTRYPOINT ["socat"]
