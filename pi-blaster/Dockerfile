FROM alpine:3@sha256:28bd5fe8b56d1bd048e5babf5b10710ebe0bae67db86916198a6eec434943f8b as builder

RUN apk add --no-cache \
    build-base \
    autoconf \
    automake \
    linux-headers \
    git

WORKDIR /pi-blaster
RUN git clone https://github.com/sarfata/pi-blaster.git .

RUN ./autogen.sh
RUN ./configure
RUN make

FROM alpine:3@sha256:28bd5fe8b56d1bd048e5babf5b10710ebe0bae67db86916198a6eec434943f8b

RUN apk --no-cache upgrade libssl3 libcrypto3
COPY --from=builder /pi-blaster/pi-blaster /

CMD ["/pi-blaster", "-D"]
