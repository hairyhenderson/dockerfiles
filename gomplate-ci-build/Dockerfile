FROM vault:1.0.1 AS vault
FROM consul:1.4.0 AS consul
FROM docker:18.09 AS docker

FROM golang:1.11.4

RUN mkdir -p /tmp/test-results
RUN go get -u github.com/Masterminds/glide
RUN go get -u github.com/golang/dep/cmd/dep
RUN go get -u github.com/jstemmer/go-junit-report
RUN go get -u github.com/alecthomas/gometalinter \
  && gometalinter --install
RUN apt-get update \
  && DEBIAN_FRONTEND=noninteractive apt-get install -yq --no-install-recommends \
    unzip \
    bats \
    jq \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*
COPY --from=vault /bin/vault /bin/vault
COPY --from=consul /bin/consul /bin/consul
COPY --from=docker /usr/local/bin/docker /bin/docker
RUN curl -sSL -o /bin/cc-test-reporter https://codeclimate.com/downloads/test-reporter/test-reporter-latest-linux-amd64
RUN chmod +x /bin/cc-test-reporter
