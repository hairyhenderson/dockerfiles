FROM hashicorp/vault:1.7.1 AS vault
FROM hairyhenderson/gomplate:v3.9.0-slim AS gomplate
FROM node:16

LABEL org.opencontainers.image.source https://github.com/hairyhenderson/dockerfiles

COPY --from=vault /bin/vault /bin/vault
COPY --from=gomplate /gomplate /bin/gomplate
