FROM hashicorp/vault:1.19.0 AS vault
FROM hashicorp/consul:1.20.4 AS consul
FROM docker:28.0 AS docker
FROM ghcr.io/hairyhenderson/bashbrew:latest AS bashbrew
FROM docker/buildx-bin:0.21.2 AS buildx-plugin
FROM golangci/golangci-lint:v1.64.7-alpine AS golangci-lint

FROM golang:1.24-alpine AS go-junit-report
RUN go install github.com/jstemmer/go-junit-report@latest

FROM golang:1.24-alpine AS final

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
