FROM ghcr.io/hairyhenderson/gomplate:v5.2.0@sha256:991ce1b8a1307fa32f9b8050a7b339697464664236cfddb1c4079df4aa5f1cd4 AS gomplate
FROM ghcr.io/hairyhenderson/bashbrew:latest@sha256:bd58604fe89dda1d168f1659a46a1f7d64d690809cc5adebc9c4479d6abe4504 AS bashbrew
FROM docker:29.8@sha256:7dcdfc4a20246236f558175182ccace1eb15a41bd3eb119dd2284f393498b7c1 AS docker
FROM docker/buildx-bin:0.37.2@sha256:f3acee6a2e18c8528ea096762e21e4c793c5a8001380f28801701b2112ae932a AS buildx-plugin
FROM mikefarah/yq:4@sha256:4b3d9475d65571d28cbb19544d3820ec2945e4c8b2f18279394282b8dc3a592e AS yq

FROM alpine:3.24@sha256:294b683cb724975bec92580e1e685676bd4b50bda910ddb8c51d4cabeaec77e6 AS runtime

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
