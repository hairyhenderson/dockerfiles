FROM golang:1.15.0 AS build

RUN CGO_ENABLED=0 go get github.com/dgrijalva/jwt-go/cmd/jwt

FROM scratch

COPY --from=build /go/bin/jwt /jwt

ENTRYPOINT ["/jwt"]
CMD ["--help"]
