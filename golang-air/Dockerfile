FROM golang:1.22 AS build

RUN go install github.com/cosmtrek/air@latest

FROM golang:1.22 AS runtime

LABEL org.opencontainers.image.source https://github.com/hairyhenderson/dockerfiles

# temporary workaround for CVEs in older versions of linux-libc-dev
RUN apt-get update && apt-get upgrade -y linux-libc-dev

COPY --from=build /go/bin/air /bin/air
