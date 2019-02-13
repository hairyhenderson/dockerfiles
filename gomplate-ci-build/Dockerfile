FROM vault:1.0.3 AS vault
FROM consul:1.4.2 AS consul
FROM docker:18.09 AS docker

FROM golang:1.11.5 AS gometalinter

WORKDIR /gometalinter/
RUN wget -O /tmp/gometalinter.tar.gz https://github.com/alecthomas/gometalinter/releases/download/v2.0.12/gometalinter-2.0.12-linux-amd64.tar.gz
RUN tar zx -C . --strip-components=1 -f /tmp/gometalinter.tar.gz

FROM golang:1.11.5 AS golangci-lint

WORKDIR /golangci-lint/
RUN wget -O /tmp/golangci-lint.tar.gz https://github.com/golangci/golangci-lint/releases/download/v1.12.5/golangci-lint-1.12.5-linux-amd64.tar.gz
RUN tar zx -C . --strip-components=1 -f /tmp/golangci-lint.tar.gz

FROM golang:1.11.5 AS cc-test-reporter

RUN curl -sSL -o /bin/cc-test-reporter https://codeclimate.com/downloads/test-reporter/test-reporter-latest-linux-amd64
RUN chmod +x /bin/cc-test-reporter

FROM golang:1.11.5 AS glide
RUN go get -u github.com/Masterminds/glide

FROM golang:1.11.5 AS dep
RUN go get -u github.com/golang/dep/cmd/dep

FROM golang:1.11.5 AS go-junit-report
RUN go get -u github.com/jstemmer/go-junit-report

FROM golang:1.11.5 AS final

RUN mkdir -p /tmp/test-results

RUN apt-get update \
  && DEBIAN_FRONTEND=noninteractive apt-get install -yq --no-install-recommends \
    unzip \
    bats \
    jq \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

COPY --from=gometalinter /gometalinter/* /bin/
COPY --from=golangci-lint /golangci-lint/* /bin/
COPY --from=vault /bin/vault /bin/vault
COPY --from=consul /bin/consul /bin/consul
COPY --from=docker /usr/local/bin/docker /bin/docker
COPY --from=cc-test-reporter /bin/cc-test-reporter /bin/cc-test-reporter
COPY --from=glide /go/bin/glide /bin/glide
COPY --from=dep /go/bin/dep /bin/dep
COPY --from=go-junit-report /go/bin/go-junit-report /bin/go-junit-report
