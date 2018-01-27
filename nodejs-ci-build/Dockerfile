FROM node:8

RUN apt-get update \
  && DEBIAN_FRONTEND=noninteractive apt-get install -yq --no-install-recommends \
    unzip \
  && curl -L -o /tmp/vault.zip https://releases.hashicorp.com/vault/0.7.0/vault_0.7.0_linux_amd64.zip \
  && unzip -d /tmp /tmp/vault.zip \
  && mv /tmp/vault /bin/vault \
  && rm -rf /tmp/vault.zip \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*
RUN curl -o /bin/gomplate -sSL -f https://github.com/hairyhenderson/gomplate/releases/download/v2.2.0/gomplate_linux-amd64-slim \
  && chmod 755 /bin/gomplate
