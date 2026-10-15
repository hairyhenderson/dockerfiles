FROM hashicorp/vault:2.1.2@sha256:c2f666266f383d2cf424d86b8bb8ce7d065562173ffec2b476d762943608bb55 AS vault
FROM hashicorp/consul:2.0.4@sha256:1c59f007df8ea1c21b2558dc73ef8d99047bc895d9e52e635d1e745e35fe9a54 AS consul
FROM docker:29.8@sha256:1e08cdb63405ca788aea94ef35b792d1e299607c667d33d7bcbcae1fd2611ced AS docker
FROM docker/buildx-bin:0.38.0@sha256:abcf2315937f37bdb52615d1698a4696e3952e88c440a07e7552cbefbc72b1b6 AS buildx-plugin
FROM golangci/golangci-lint:v2.14.0-alpine@sha256:25925c95ebdc7aee39ecc0e6f4f33ac27b9a91718bc65fdf18a1a5c4c9325ee4 AS golangci-lint

FROM golang:1.27@sha256:3680233e3204827fbdc66088528ae6d4b3d034f51d03a99d454f6de034888244 AS go-junit-report
RUN go install github.com/jstemmer/go-junit-report@latest

FROM golang:1.27@sha256:3680233e3204827fbdc66088528ae6d4b3d034f51d03a99d454f6de034888244 AS final

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
