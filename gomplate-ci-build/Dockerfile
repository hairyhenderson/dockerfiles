FROM vault:0.11.0 AS vault

FROM consul:1.2.2 AS consul

FROM golang:1.11.0

RUN mkdir -p /tmp/test-results
RUN go get -u github.com/Masterminds/glide
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
RUN curl -sSL -o /bin/cc-test-reporter https://codeclimate.com/downloads/test-reporter/test-reporter-latest-linux-amd64
RUN chmod +x /bin/cc-test-reporter
