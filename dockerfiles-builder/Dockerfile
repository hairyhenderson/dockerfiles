FROM hairyhenderson/gomplate:v3.5.0-slim AS gomplate

FROM alpine:3.10 AS runtime

RUN apk add --no-cache make
COPY --from=gomplate /gomplate /bin/gomplate
