FROM golang:1.10

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
COPY --from=vault:0.10.1 /bin/vault /bin/vault
COPY --from=consul:1.0.7 /bin/consul /bin/consul
