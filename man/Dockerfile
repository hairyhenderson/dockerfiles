FROM alpine:3.24@sha256:f59abe656b692d901e184be3445e084786602108599d2a51d229c0f5a48c71bf

LABEL org.opencontainers.image.source=https://github.com/hairyhenderson/dockerfiles

ENV PAGER /usr/bin/less
RUN apk add --no-cache mandoc man-pages util-linux-doc e2fsprogs-doc

USER 42000:42000

ENTRYPOINT ["man"]
