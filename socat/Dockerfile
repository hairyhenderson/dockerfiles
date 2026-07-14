FROM alpine:3.24@sha256:28bd5fe8b56d1bd048e5babf5b10710ebe0bae67db86916198a6eec434943f8b

LABEL org.opencontainers.image.source=https://github.com/hairyhenderson/dockerfiles

RUN apk add --no-cache \
  ca-certificates \
  socat

ENTRYPOINT ["socat"]
