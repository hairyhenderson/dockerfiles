FROM golang:1.8

RUN mkdir -p /tmp/test-results
RUN go get -u github.com/Masterminds/glide
RUN go get -u github.com/jstemmer/go-junit-report
RUN go get -u github.com/alecthomas/gometalinter \
  && gometalinter --install
RUN echo "deb http://deb.debian.org/debian jessie-backports main" >> /etc/apt/sources.list
RUN apt-get update \
  && DEBIAN_FRONTEND=noninteractive apt-get install -yq --no-install-recommends \
    unzip \
    bats \
  && curl -L -o /tmp/vault.zip https://releases.hashicorp.com/vault/0.7.0/vault_0.7.0_linux_amd64.zip \
  && unzip -d /tmp /tmp/vault.zip \
  && mv /tmp/vault /bin/vault \
  && rm -rf /tmp/vault.zip \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*
