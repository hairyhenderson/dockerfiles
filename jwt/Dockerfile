FROM golang:1.19-alpine AS build

LABEL org.opencontainers.image.source https://github.com/hairyhenderson/dockerfiles

RUN CGO_ENABLED=0 go install github.com/golang-jwt/jwt/cmd/jwt@latest

FROM scratch

COPY --from=build /go/bin/jwt /jwt

ENTRYPOINT ["/jwt"]
CMD ["--help"]
