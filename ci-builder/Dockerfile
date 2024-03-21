FROM vault:1.13.3 AS vault
FROM consul:1.15.4 AS consul
FROM docker:26.0 AS docker
FROM ghcr.io/hairyhenderson/bashbrew:latest AS bashbrew
FROM docker/buildx-bin:0.13.1 AS buildx-plugin
FROM golangci/golangci-lint:v1.56.2-alpine AS golangci-lint

FROM alpine:3.19 AS cc-test-reporter

RUN set -eux; \
	apkArch="$(apk --print-arch)"; \
	case "$apkArch" in \
		x86_64) \
			wget -qO /bin/cc-test-reporter https://codeclimate.com/downloads/test-reporter/test-reporter-latest-linux-amd64 \
			;; \
		*) \
			echo >&2 "error: unsupported architecture ($apkArch), skipping"; \
			echo -ne "#!/bin/sh\necho not on this arch!\n" > /bin/cc-test-reporter \
			;; \
	esac; \
	chmod +x /bin/cc-test-reporter

FROM golang:1.22-alpine AS go-junit-report
RUN go install github.com/jstemmer/go-junit-report@latest

FROM golang:1.22-alpine AS final

LABEL org.opencontainers.image.source https://github.com/hairyhenderson/dockerfiles

RUN mkdir -p /tmp/test-results

RUN apk --no-cache add \
	unzip jq git \
	build-base
RUN apk --no-cache upgrade \
	libssl3 \
	libcrypto3

ENV DOCKER_BUILDKIT=1
ENV GOFLAGS=-buildvcs=false

COPY --from=golangci-lint /usr/bin/golangci-lint /bin/
COPY --from=vault /bin/vault /bin/vault
COPY --from=consul /bin/consul /bin/consul
COPY --from=docker /usr/local/bin/docker /bin/docker
COPY --from=cc-test-reporter /bin/cc-test-reporter /bin/cc-test-reporter
COPY --from=go-junit-report /go/bin/go-junit-report /bin/go-junit-report
COPY --from=buildx-plugin /buildx /usr/libexec/docker/cli-plugins/docker-buildx
COPY --from=bashbrew /bin/bashbrew /bin/bashbrew
