FROM alpine:edge

LABEL org.opencontainers.image.source https://github.com/hairyhenderson/dockerfiles

RUN apk add --no-cache upx=3.96-r0

ENTRYPOINT [ "/usr/bin/upx" ]
