FROM hashicorp/vault:1.21.4@sha256:4e33b126a59c0c333b76fb4e894722462659a6bec7c48c9ee8cea56fccfd2569 AS vault
FROM hashicorp/consul:1.22.7@sha256:a230dcea0bb107bd7958a912d1429fb7f9d399637de7ffb814b34412b9e8c543 AS consul
FROM docker:29.6@sha256:66d292e5c26bd33a6f6f61cacb880de2186339a524ecba1ce098dbbaceed6515 AS docker
FROM ghcr.io/hairyhenderson/bashbrew:latest AS bashbrew
FROM docker/buildx-bin:0.35.0@sha256:917570d8d0ae91ae49251f84f848a6801eedd114554c56a4fdf7ec88cac48eeb AS buildx-plugin
FROM golangci/golangci-lint:v2.8.0-alpine AS golangci-lint

FROM golang:1.25-alpine AS go-junit-report
RUN go install github.com/jstemmer/go-junit-report@latest

FROM golang:1.25-alpine AS final

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
