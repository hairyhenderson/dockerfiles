FROM hairyhenderson/gomplate:v3.6.0-slim AS gomplate

FROM alpine:3.11 AS runtime

RUN apk add --no-cache make
COPY --from=gomplate /gomplate /bin/gomplate
