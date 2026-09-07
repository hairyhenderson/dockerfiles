FROM ghcr.io/hairyhenderson/gomplate:v5.2.0@sha256:991ce1b8a1307fa32f9b8050a7b339697464664236cfddb1c4079df4aa5f1cd4 AS gomplate
FROM ghcr.io/hairyhenderson/bashbrew:latest@sha256:831474fe19e06fbc65b6239e9e7196ce1fbb706805852623fd78b7488c98885f AS bashbrew
FROM docker:29.7@sha256:3ef33f2e220b79ed3ef3b99d81746f06f306cd6340e2cb7331d17ae996e74cb6 AS docker
FROM docker/buildx-bin:0.36.1@sha256:1f2f6b2be4a2511ada67336e76892f1a588c89746009dd4b21069e4d867465be AS buildx-plugin
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
