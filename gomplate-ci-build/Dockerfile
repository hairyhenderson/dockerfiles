FROM hashicorp/vault:2.1.0@sha256:5520cc26271c024e6ffa45cdf95255bd26b70d71ba4b7e0bc18925bef4128adb AS vault
FROM hashicorp/consul:2.0.4@sha256:1c59f007df8ea1c21b2558dc73ef8d99047bc895d9e52e635d1e745e35fe9a54 AS consul
FROM docker:29.8@sha256:5efed980cba3fc126cf54e21a5a6ff8849d05b6e0623d6e7612f48e9cd6cd17e AS docker
FROM docker/buildx-bin:0.37.1@sha256:0ef4e936b9057e45a8c6595c01a8116353acd102b6a5720af7c3bcb50346e2ca AS buildx-plugin
FROM golangci/golangci-lint:v2.13.2-alpine@sha256:da1f79b184ff1d98781648407d05a99b9cba7b282aa3416b0a0eac102a3b0557 AS golangci-lint

FROM golang:1.27@sha256:f44f6e88636cfb311f9ebace870ded69d943f227bb3cb27d32ffd84ea18c43ea AS go-junit-report
RUN go install github.com/jstemmer/go-junit-report@latest

FROM golang:1.27@sha256:f44f6e88636cfb311f9ebace870ded69d943f227bb3cb27d32ffd84ea18c43ea AS final

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
