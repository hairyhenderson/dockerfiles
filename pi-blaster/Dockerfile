FROM alpine:3@sha256:294b683cb724975bec92580e1e685676bd4b50bda910ddb8c51d4cabeaec77e6 as builder

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

FROM alpine:3@sha256:294b683cb724975bec92580e1e685676bd4b50bda910ddb8c51d4cabeaec77e6

RUN apk --no-cache upgrade libssl3 libcrypto3
COPY --from=builder /pi-blaster/pi-blaster /

CMD ["/pi-blaster", "-D"]
