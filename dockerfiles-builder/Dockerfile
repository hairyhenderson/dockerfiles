FROM ghcr.io/hairyhenderson/gomplate:v4.3 AS gomplate
FROM ghcr.io/hairyhenderson/bashbrew:latest AS bashbrew
FROM docker:28.3 AS docker
FROM docker/buildx-bin:0.25.0 AS buildx-plugin
FROM mikefarah/yq:4 AS yq

FROM alpine:3.22 AS runtime

LABEL org.opencontainers.image.source=https://github.com/hairyhenderson/dockerfiles

RUN apk add --no-cache make bash git curl ca-certificates

COPY --from=gomplate /gomplate /bin/gomplate
COPY --from=bashbrew /bin/bashbrew /bin/bashbrew
COPY --from=docker /usr/local/bin/docker /bin/docker
COPY --from=buildx-plugin /buildx /usr/libexec/docker/cli-plugins/docker-buildx
COPY --from=yq /usr/bin/yq /usr/bin/yq

ENV DOCKER_BUILDKIT=1
ENV GOFLAGS=-buildvcs=false

RUN ln -fs /bin/bash /bin/sh
