FROM golang:1.15.4 AS build

LABEL org.opencontainers.image.source https://github.com/hairyhenderson/dockerfiles

RUN CGO_ENABLED=0 go get github.com/dgrijalva/jwt-go/cmd/jwt

FROM scratch

COPY --from=build /go/bin/jwt /jwt

ENTRYPOINT ["/jwt"]
CMD ["--help"]
