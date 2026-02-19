FROM hashicorp/vault:1.21.3 AS vault
FROM hashicorp/consul:1.22.4 AS consul
FROM docker:29.2 AS docker
FROM docker/buildx-bin:0.31.1 AS buildx-plugin
FROM golangci/golangci-lint:v2.10.1-alpine AS golangci-lint

FROM golang:1.26 AS go-junit-report
RUN go install github.com/jstemmer/go-junit-report@latest

FROM golang:1.26 AS final

LABEL org.opencontainers.image.source=https://github.com/hairyhenderson/dockerfiles

RUN mkdir -p /tmp/test-results

RUN apt-get update \
	&& DEBIAN_FRONTEND=noninteractive dpkg --purge libsvn1 subversion libaprutil1 libserf-1-1 \
	&& DEBIAN_FRONTEND=noninteractive apt-get install -yq --no-install-recommends \
		unzip \
		jq \
	&& apt-get upgrade -y linux-libc-dev \
	&& apt-get clean \
	&& rm -rf /var/lib/apt/lists/*

ENV DOCKER_BUILDKIT=1
ENV GOFLAGS=-buildvcs=false

COPY --from=golangci-lint /usr/bin/golangci-lint /bin/
COPY --from=vault /bin/vault /bin/vault
COPY --from=consul /bin/consul /bin/consul
COPY --from=docker /usr/local/bin/docker /bin/docker
COPY --from=go-junit-report /go/bin/go-junit-report /bin/go-junit-report
COPY --from=buildx-plugin /buildx /usr/libexec/docker/cli-plugins/docker-buildx
