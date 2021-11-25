FROM alpine:3.15

LABEL org.opencontainers.image.source https://github.com/hairyhenderson/dockerfiles

ENV PAGER /usr/bin/less
RUN apk add --no-cache mandoc man-pages util-linux-doc e2fsprogs-doc

USER 42000:42000

ENTRYPOINT ["man"]
