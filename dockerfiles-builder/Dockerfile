FROM hairyhenderson/gomplate:v3.9.0-slim AS gomplate
FROM hairyhenderson/bashbrew:latest AS bashbrew
FROM docker:20.10.5 AS docker
FROM mikefarah/yq:4.6.3 AS yq

FROM alpine:3.13.4 AS runtime

LABEL org.opencontainers.image.source https://github.com/hairyhenderson/dockerfiles

RUN apk add --no-cache make bash git curl ca-certificates
COPY --from=gomplate /gomplate /bin/gomplate
COPY --from=bashbrew /bin/bashbrew /bin/bashbrew
COPY --from=docker /usr/local/bin/docker /bin/docker
COPY --from=yq /usr/bin/yq /usr/bin/yq

RUN ln -fs /bin/bash /bin/sh
