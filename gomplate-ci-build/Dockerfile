FROM hashicorp/vault:2.2.2@sha256:dfa48c2fa2b0099ccb47681ec5c4804bf5aec9d6879ecfee07ad4b92a5427ad6 AS vault
FROM hashicorp/consul:2.1.0@sha256:259fd02f2544fe1aa03fa49efd3b105c8dd67106d710a72f5e898110266356f7 AS consul
FROM docker:29.9@sha256:7bf70dcb85c822e3fa6f2d332143e474b99147b9d7b39102b0cfe8b04a7dd61b AS docker
FROM docker/buildx-bin:0.39.0@sha256:aa2eb88bded47a9ea6f6eb88eb2db525ac55c3fa10b7e0d683035d5e4acc2050 AS buildx-plugin
FROM golangci/golangci-lint:v2.15.0-alpine@sha256:2ba875b990f1d8501ad4ec19be1ea0701e316ec3a4b764f7b129f62f01318bbf AS golangci-lint

FROM golang:1.27.3@sha256:e519d3b0a5b285e5aa53ab9eef02bc6bbb9cb04608389b743a136a9ce75f0d1e AS go-junit-report
RUN go install github.com/jstemmer/go-junit-report@latest

FROM golang:1.27.3@sha256:e519d3b0a5b285e5aa53ab9eef02bc6bbb9cb04608389b743a136a9ce75f0d1e AS final

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
