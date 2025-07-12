FROM alpine:3.22

LABEL org.opencontainers.image.source=https://github.com/hairyhenderson/dockerfiles

RUN apk --no-cache add sed
RUN apk --no-cache upgrade libssl3 libcrypto3

ENTRYPOINT ["sed"]
