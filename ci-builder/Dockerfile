FROM hashicorp/vault:2.1.0@sha256:5520cc26271c024e6ffa45cdf95255bd26b70d71ba4b7e0bc18925bef4128adb AS vault
FROM hashicorp/consul:2.0.3@sha256:56a8d0fdbfcb35836c4ce2fc8a5d34eac48594ef067bbe4af7d5ceb9fb08c28d AS consul
FROM docker:29.7@sha256:3ef33f2e220b79ed3ef3b99d81746f06f306cd6340e2cb7331d17ae996e74cb6 AS docker
FROM ghcr.io/hairyhenderson/bashbrew:latest@sha256:957874fb9fffa33f5af52cb0aad2b7179612515b802d9a7ada301e356bf1641d AS bashbrew
FROM docker/buildx-bin:0.36.1@sha256:1f2f6b2be4a2511ada67336e76892f1a588c89746009dd4b21069e4d867465be AS buildx-plugin
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
