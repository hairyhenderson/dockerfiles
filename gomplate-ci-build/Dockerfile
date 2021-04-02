FROM vault:1.7.0 AS vault
FROM consul:1.9.4 AS consul
FROM docker:20.10.5 AS docker
FROM golangci/golangci-lint:v1.39.0-alpine AS golangci-lint
FROM hairyhenderson/bashbrew:latest AS bashbrew
FROM hairyhenderson/buildx:latest AS buildx-plugin

FROM alpine:3.13.4 AS cc-test-reporter

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

FROM golang:1.16.3 AS go-junit-report
RUN go get -u github.com/jstemmer/go-junit-report

FROM golang:1.16.3 AS final

LABEL org.opencontainers.image.source https://github.com/hairyhenderson/dockerfiles

RUN mkdir -p /tmp/test-results

RUN apt-get update \
  && DEBIAN_FRONTEND=noninteractive apt-get install -yq --no-install-recommends \
    unzip \
    jq \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

COPY --from=golangci-lint /usr/bin/golangci-lint /bin/
COPY --from=vault /bin/vault /bin/vault
COPY --from=consul /bin/consul /bin/consul
COPY --from=docker /usr/local/bin/docker /bin/docker
COPY --from=cc-test-reporter /bin/cc-test-reporter /bin/cc-test-reporter
COPY --from=go-junit-report /go/bin/go-junit-report /bin/go-junit-report
COPY --from=buildx-plugin /buildx /usr/lib/docker/cli-plugins/docker-buildx
COPY --from=bashbrew /bin/bashbrew /bin/bashbrew
