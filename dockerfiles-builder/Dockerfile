FROM hairyhenderson/gomplate:v3.6.0-slim AS gomplate
FROM hairyhenderson/bashbrew:latest AS bashbrew
FROM docker:19.03.6 AS docker

FROM alpine:3.11 AS runtime

RUN apk add --no-cache make bash git curl ca-certificates
COPY --from=gomplate /gomplate /bin/gomplate
COPY --from=bashbrew /bin/bashbrew /bin/bashbrew
COPY --from=docker /usr/local/bin/docker /bin/docker
RUN ln -fs /bin/bash /bin/sh
