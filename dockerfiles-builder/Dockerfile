FROM hairyhenderson/gomplate:v3.7.0-slim AS gomplate
FROM hairyhenderson/bashbrew:latest AS bashbrew
FROM docker:19.03.11 AS docker
FROM mikefarah/yq:3.3.2 AS yq

FROM alpine:3.12.0 AS runtime

RUN apk add --no-cache make bash git curl ca-certificates
COPY --from=gomplate /gomplate /bin/gomplate
COPY --from=bashbrew /bin/bashbrew /bin/bashbrew
COPY --from=docker /usr/local/bin/docker /bin/docker
COPY --from=yq /usr/bin/yq /usr/bin/yq

RUN ln -fs /bin/bash /bin/sh
