FROM golang:1.17.6

LABEL org.opencontainers.image.source https://github.com/hairyhenderson/dockerfiles

# temporary workaround for CVEs in older versions of linux-libc-dev
RUN apt-get update && apt-get upgrade -y linux-libc-dev

RUN go install github.com/cosmtrek/air@latest
