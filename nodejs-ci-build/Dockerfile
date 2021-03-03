FROM hashicorp/vault:1.6.3 AS vault
FROM hairyhenderson/gomplate:v3.9.0-slim AS gomplate
FROM node:15

LABEL org.opencontainers.image.source https://github.com/hairyhenderson/dockerfiles

COPY --from=vault /bin/vault /bin/vault
COPY --from=gomplate /gomplate /bin/gomplate
