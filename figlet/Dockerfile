FROM alpine:3

LABEL org.opencontainers.image.source=https://github.com/hairyhenderson/dockerfiles

RUN apk add --no-cache figlet
RUN apk --no-cache upgrade libssl3 libcrypto3

ENTRYPOINT ["figlet"]
