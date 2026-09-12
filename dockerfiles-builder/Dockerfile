FROM ghcr.io/hairyhenderson/gomplate:v5.2.0@sha256:991ce1b8a1307fa32f9b8050a7b339697464664236cfddb1c4079df4aa5f1cd4 AS gomplate
FROM ghcr.io/hairyhenderson/bashbrew:latest@sha256:957874fb9fffa33f5af52cb0aad2b7179612515b802d9a7ada301e356bf1641d AS bashbrew
FROM docker:29.8@sha256:5efed980cba3fc126cf54e21a5a6ff8849d05b6e0623d6e7612f48e9cd6cd17e AS docker
FROM docker/buildx-bin:0.37.0@sha256:1387e0aa2b756894e8b6ee10d0f80904cb0badc4356a29e7843b230d0b8fd48f AS buildx-plugin
FROM mikefarah/yq:4@sha256:cfc4eee658595834ef304eadb0c3ea721f3b7cb6404ad8b7cb909cc5b5145b23 AS yq

FROM alpine:3.24@sha256:28bd5fe8b56d1bd048e5babf5b10710ebe0bae67db86916198a6eec434943f8b AS runtime

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
