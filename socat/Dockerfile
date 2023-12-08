FROM alpine:3.19

LABEL org.opencontainers.image.source https://github.com/hairyhenderson/dockerfiles

RUN apk add --no-cache \
  ca-certificates \
  socat
RUN apk --no-cache upgrade libssl3 libcrypto3

ENTRYPOINT ["socat"]
