FROM alpine:3.24@sha256:be2656061b536c1883c4034790e21d0a09c5aaaf51968b89368a3c0371ea2c9a

LABEL org.opencontainers.image.source=https://github.com/hairyhenderson/dockerfiles

RUN apk --no-cache add sed
RUN apk --no-cache upgrade libssl3 libcrypto3

ENTRYPOINT ["sed"]
