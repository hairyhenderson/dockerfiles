FROM alpine:3.24@sha256:be2656061b536c1883c4034790e21d0a09c5aaaf51968b89368a3c0371ea2c9a

LABEL org.opencontainers.image.source=https://github.com/hairyhenderson/dockerfiles

ENV PAGER /usr/bin/less
RUN apk add --no-cache mandoc man-pages util-linux-doc e2fsprogs-doc

USER 42000:42000

ENTRYPOINT ["man"]
