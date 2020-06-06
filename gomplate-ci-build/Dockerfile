FROM vault:1.4.2 AS vault
FROM consul:1.7.3 AS consul
FROM docker:19.03.11 AS docker
FROM golangci/golangci-lint:v1.27.0 AS golangci-lint
FROM hairyhenderson/bashbrew:latest AS bashbrew
FROM hairyhenderson/buildx:latest AS buildx-plugin

# FROM golang:1.14.2 AS buildx-plugin

# RUN curl -sSL -o /docker-buildx https://github.com/docker/buildx/releases/download/v0.3.1/buildx-v0.3.1.linux-amd64
# RUN chmod 755 /docker-buildx

FROM alpine:3.12.0 AS cc-test-reporter

RUN set -eux; \
  apkArch="$(apk --print-arch)"; \
	case "$apkArch" in \
		x86_64) \
			wget -O /bin/cc-test-reporter https://codeclimate.com/downloads/test-reporter/test-reporter-latest-linux-amd64 \
			;; \
		*) \
			echo >&2 "error: unsupported architecture ($apkArch), skipping"; \
			echo -ne "#!/bin/sh\necho not on this arch!\n" > /bin/cc-test-reporter \
			;; \
	esac; \
	chmod +x /bin/cc-test-reporter

FROM golang:1.14.4 AS dep
RUN go get -u github.com/golang/dep/cmd/dep

FROM golang:1.14.4 AS go-junit-report
RUN go get -u github.com/jstemmer/go-junit-report

# FROM golang:1.14.2 AS reg

# ENV REG_SHA256=ade837fc5224acd8c34732bf54a94f579b47851cc6a7fd5899a98386b782e228
# ENV REG_VERSION=v0.16.1

# RUN curl -sSL -o /bin/reg https://github.com/genuinetools/reg/releases/download/${REG_VERSION}/reg-linux-amd64
# RUN echo "${REG_SHA256}  /bin/reg" | sha256sum -c -
# RUN chmod a+x "/bin/reg"

FROM golang:1.14.4 AS final

RUN mkdir -p /tmp/test-results

RUN apt-get update \
  && DEBIAN_FRONTEND=noninteractive apt-get install -yq --no-install-recommends \
    unzip \
    bats \
    jq \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

COPY --from=golangci-lint /usr/bin/golangci-lint /bin/
COPY --from=vault /bin/vault /bin/vault
COPY --from=consul /bin/consul /bin/consul
COPY --from=docker /usr/local/bin/docker /bin/docker
COPY --from=cc-test-reporter /bin/cc-test-reporter /bin/cc-test-reporter
COPY --from=dep /go/bin/dep /bin/dep
COPY --from=go-junit-report /go/bin/go-junit-report /bin/go-junit-report
COPY --from=buildx-plugin /buildx /usr/lib/docker/cli-plugins/docker-buildx
# COPY --from=reg /bin/reg /bin/reg
COPY --from=bashbrew /bin/bashbrew /bin/bashbrew
