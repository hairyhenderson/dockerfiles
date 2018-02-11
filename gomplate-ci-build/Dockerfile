FROM golang:1.9

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
  && curl -L -o /tmp/vault.zip https://releases.hashicorp.com/vault/0.9.3/vault_0.9.3_linux_amd64.zip \
  && unzip -d /tmp /tmp/vault.zip \
  && mv /tmp/vault /bin/vault \
  && rm -rf /tmp/vault.zip \
  && curl -L -o /tmp/consul.zip https://releases.hashicorp.com/consul/1.0.3/consul_1.0.3_linux_amd64.zip \
  && unzip -d /tmp /tmp/consul.zip \
  && mv /tmp/consul /bin/consul \
  && rm -rf /tmp/consul.zip \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*
