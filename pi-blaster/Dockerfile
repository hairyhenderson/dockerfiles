FROM alpine:3 as builder

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

FROM alpine:3

COPY --from=builder /pi-blaster/pi-blaster /

CMD ["/pi-blaster", "-D"]
