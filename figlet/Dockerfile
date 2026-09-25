FROM alpine:3@sha256:294b683cb724975bec92580e1e685676bd4b50bda910ddb8c51d4cabeaec77e6

LABEL org.opencontainers.image.source=https://github.com/hairyhenderson/dockerfiles

RUN apk add --no-cache figlet
RUN apk --no-cache upgrade libssl3 libcrypto3

ENTRYPOINT ["figlet"]
