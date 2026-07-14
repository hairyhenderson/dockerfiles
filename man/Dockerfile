FROM alpine:3.24@sha256:28bd5fe8b56d1bd048e5babf5b10710ebe0bae67db86916198a6eec434943f8b

LABEL org.opencontainers.image.source=https://github.com/hairyhenderson/dockerfiles

ENV PAGER /usr/bin/less
RUN apk add --no-cache mandoc man-pages util-linux-doc e2fsprogs-doc

USER 42000:42000

ENTRYPOINT ["man"]
