FROM alpine:3.14.0

LABEL org.opencontainers.image.source https://github.com/hairyhenderson/dockerfiles

RUN apk add --no-cache upx=3.96-r1

ENTRYPOINT [ "/usr/bin/upx" ]
