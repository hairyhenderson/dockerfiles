FROM ghcr.io/hairyhenderson/gomplate:v5.2.0@sha256:991ce1b8a1307fa32f9b8050a7b339697464664236cfddb1c4079df4aa5f1cd4 AS gomplate
FROM ghcr.io/hairyhenderson/bashbrew:latest@sha256:6a9f3780d8f5965122ef5cab9b7e457084e54e93854cb7f62b7401f714d28792 AS bashbrew
FROM docker:29.9@sha256:08a98015fce594af7c382883bea080ea206de74402a95da9dc52b6428c8cd121 AS docker
FROM docker/buildx-bin:0.38.2@sha256:1fb51a05e9455e21396698b774446ff80d80fd53f17079d82aaee9c195f962f9 AS buildx-plugin
FROM mikefarah/yq:4@sha256:7834187596ad56fd5a81436114e0b0b9dd54c91bb43946d1f7145b2be5f9c3d2 AS yq

FROM alpine:3.24@sha256:f59abe656b692d901e184be3445e084786602108599d2a51d229c0f5a48c71bf AS runtime

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
