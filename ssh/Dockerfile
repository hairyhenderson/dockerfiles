FROM alpine:3@sha256:be2656061b536c1883c4034790e21d0a09c5aaaf51968b89368a3c0371ea2c9a

LABEL org.opencontainers.image.source=https://github.com/hairyhenderson/dockerfiles
RUN apk --no-cache add openssh-client

ENTRYPOINT ["ssh"]
