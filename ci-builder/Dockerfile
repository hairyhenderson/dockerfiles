FROM hashicorp/vault:2.2.1@sha256:962a92876e168d68eaaa24b0b8b49bbce1cb63024060a67bba95cd158a366fc2 AS vault
FROM hashicorp/consul:2.1.0@sha256:259fd02f2544fe1aa03fa49efd3b105c8dd67106d710a72f5e898110266356f7 AS consul
FROM docker:29.9@sha256:08a98015fce594af7c382883bea080ea206de74402a95da9dc52b6428c8cd121 AS docker
FROM ghcr.io/hairyhenderson/bashbrew:latest@sha256:6a9f3780d8f5965122ef5cab9b7e457084e54e93854cb7f62b7401f714d28792 AS bashbrew
FROM docker/buildx-bin:0.38.2@sha256:1fb51a05e9455e21396698b774446ff80d80fd53f17079d82aaee9c195f962f9 AS buildx-plugin
FROM golangci/golangci-lint:v2.15.0-alpine@sha256:2ba875b990f1d8501ad4ec19be1ea0701e316ec3a4b764f7b129f62f01318bbf AS golangci-lint

FROM golang:1.27-alpine@sha256:d200d2dd76b03a99b52651fd1325aff7dcd35422c35c01bac56571b0507f3deb AS go-junit-report
RUN go install github.com/jstemmer/go-junit-report@latest

FROM golang:1.27-alpine@sha256:d200d2dd76b03a99b52651fd1325aff7dcd35422c35c01bac56571b0507f3deb AS final

LABEL org.opencontainers.image.source=https://github.com/hairyhenderson/dockerfiles

RUN mkdir -p /tmp/test-results

RUN apk --no-cache add \
	unzip jq git \
	build-base

ENV DOCKER_BUILDKIT=1
ENV GOFLAGS=-buildvcs=false

COPY --from=golangci-lint /usr/bin/golangci-lint /bin/
COPY --from=vault /bin/vault /bin/vault
COPY --from=consul /bin/consul /bin/consul
COPY --from=docker /usr/local/bin/docker /bin/docker
COPY --from=go-junit-report /go/bin/go-junit-report /bin/go-junit-report
COPY --from=buildx-plugin /buildx /usr/libexec/docker/cli-plugins/docker-buildx
COPY --from=bashbrew /bin/bashbrew /bin/bashbrew
