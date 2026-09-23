FROM hashicorp/vault:2.1.1@sha256:47f14a6acb98f48d798a07df7c83f23a6e636e1cf724c5f8ff165cb32667a1e2 AS vault
FROM hashicorp/consul:2.0.4@sha256:1c59f007df8ea1c21b2558dc73ef8d99047bc895d9e52e635d1e745e35fe9a54 AS consul
FROM docker:29.8@sha256:5efed980cba3fc126cf54e21a5a6ff8849d05b6e0623d6e7612f48e9cd6cd17e AS docker
FROM ghcr.io/hairyhenderson/bashbrew:latest@sha256:957874fb9fffa33f5af52cb0aad2b7179612515b802d9a7ada301e356bf1641d AS bashbrew
FROM docker/buildx-bin:0.37.1@sha256:0ef4e936b9057e45a8c6595c01a8116353acd102b6a5720af7c3bcb50346e2ca AS buildx-plugin
FROM golangci/golangci-lint:v2.13.2-alpine@sha256:da1f79b184ff1d98781648407d05a99b9cba7b282aa3416b0a0eac102a3b0557 AS golangci-lint

FROM golang:1.27-alpine@sha256:cf6fca6641884b8433441b2b0652976f975e1d0fdd26d177eaaf8596087f3125 AS go-junit-report
RUN go install github.com/jstemmer/go-junit-report@latest

FROM golang:1.27-alpine@sha256:cf6fca6641884b8433441b2b0652976f975e1d0fdd26d177eaaf8596087f3125 AS final

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
