ARG GO_VERSION=1.18
FROM vault:1.11.0 AS vault
FROM consul:1.12 AS consul
FROM docker:20.10 AS docker
FROM hairyhenderson/bashbrew:latest AS bashbrew
FROM docker/buildx-bin:master AS buildx-plugin
FROM golangci/golangci-lint:v1.47-alpine AS golangci-lint

FROM alpine:3.16 AS cc-test-reporter

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

FROM golang:${GO_VERSION} AS go-junit-report
RUN go install github.com/jstemmer/go-junit-report@latest

FROM golang:${GO_VERSION} AS final

LABEL org.opencontainers.image.source https://github.com/hairyhenderson/dockerfiles

RUN mkdir -p /tmp/test-results

RUN apt-get update \
	&& DEBIAN_FRONTEND=noninteractive dpkg --purge libsvn1 subversion \
	&& DEBIAN_FRONTEND=noninteractive apt-get install -yq --no-install-recommends \
		unzip \
		jq \
	&& DEBIAN_FRONTEND=noninteractive apt-get install -yq --no-install-recommends \
		libldap-2.4-2>=2.4.57+dfsg-3+deb11u1 \
		openssl>=1.1.1n-0+deb11u2 \
		libssl1.1>=1.1.1n-0+deb11u2 \
	&& DEBIAN_FRONTEND=noninteractive apt-get install -yq --no-install-recommends \
		linux-libc-dev>=5.10.120-1 \
	&& apt-get clean \
	&& rm -rf /var/lib/apt/lists/*

COPY --from=golangci-lint /usr/bin/golangci-lint /bin/
COPY --from=vault /bin/vault /bin/vault
COPY --from=consul /bin/consul /bin/consul
COPY --from=docker /usr/local/bin/docker /bin/docker
COPY --from=cc-test-reporter /bin/cc-test-reporter /bin/cc-test-reporter
COPY --from=go-junit-report /go/bin/go-junit-report /bin/go-junit-report
COPY --from=buildx-plugin /buildx /usr/libexec/docker/cli-plugins/docker-buildx
COPY --from=bashbrew /bin/bashbrew /bin/bashbrew
