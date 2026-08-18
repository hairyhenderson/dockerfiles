FROM hashicorp/vault:2.0.4@sha256:5be49781ecf78bfe775c5309c6a4d9f4e9e040b6c885c99eb2b12fb69855e1a2 AS vault
FROM hashicorp/consul:2.0.3@sha256:56a8d0fdbfcb35836c4ce2fc8a5d34eac48594ef067bbe4af7d5ceb9fb08c28d AS consul
FROM docker:29.7@sha256:12e683a161823b2a839aeea999b9d960e6e1f9a97b1679ad6b441982e2d9cf07 AS docker
FROM ghcr.io/hairyhenderson/bashbrew:latest@sha256:1c32197db10d4451c2fc5cbd6a6df2f1004b4860f414f39fb4919964bc4edbe6 AS bashbrew
FROM docker/buildx-bin:0.36.1@sha256:1f2f6b2be4a2511ada67336e76892f1a588c89746009dd4b21069e4d867465be AS buildx-plugin
FROM golangci/golangci-lint:v2.12.2-alpine@sha256:91b27804074a0bacea298707f016911e60cf0cdbc6c7bf5ccacb5f0606d18d60 AS golangci-lint

FROM golang:1.26-alpine@sha256:3889b425f035be855a72fb4755265311293b6d414521f0a519d819df32222d83 AS go-junit-report
RUN go install github.com/jstemmer/go-junit-report@latest

FROM golang:1.26-alpine@sha256:3889b425f035be855a72fb4755265311293b6d414521f0a519d819df32222d83 AS final

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
