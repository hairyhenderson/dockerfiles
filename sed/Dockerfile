FROM alpine:3.24@sha256:f59abe656b692d901e184be3445e084786602108599d2a51d229c0f5a48c71bf

LABEL org.opencontainers.image.source=https://github.com/hairyhenderson/dockerfiles

RUN apk --no-cache add sed
RUN apk --no-cache upgrade libssl3 libcrypto3

ENTRYPOINT ["sed"]
