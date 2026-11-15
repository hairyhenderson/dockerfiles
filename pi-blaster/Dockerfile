FROM alpine:3@sha256:f59abe656b692d901e184be3445e084786602108599d2a51d229c0f5a48c71bf as builder

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

FROM alpine:3@sha256:f59abe656b692d901e184be3445e084786602108599d2a51d229c0f5a48c71bf

RUN apk --no-cache upgrade libssl3 libcrypto3
COPY --from=builder /pi-blaster/pi-blaster /

CMD ["/pi-blaster", "-D"]
