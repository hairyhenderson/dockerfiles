FROM vault:1.3.0 AS vault
FROM consul:1.6.2 AS consul
FROM docker:19.03 AS docker
FROM golangci/golangci-lint:v1.21.0 AS golangci-lint

FROM golang:1.13.4 AS cc-test-reporter

RUN curl -sSL -o /bin/cc-test-reporter https://codeclimate.com/downloads/test-reporter/test-reporter-latest-linux-amd64
RUN chmod +x /bin/cc-test-reporter

FROM golang:1.13.4 AS dep
RUN go get -u github.com/golang/dep/cmd/dep

FROM golang:1.13.4 AS go-junit-report
RUN go get -u github.com/jstemmer/go-junit-report

FROM golang:1.13.4 AS final

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
