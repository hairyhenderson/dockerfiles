FROM buildpack-deps:buster AS build

ENV TRX_VER=0.5

RUN mkdir /src
WORKDIR /src
RUN curl -sSLO http://www.pogo.org.uk/%7Emark/trx/releases/trx-${TRX_VER}.tar.gz
RUN tar zxf trx-${TRX_VER}.tar.gz

WORKDIR /src/trx-${TRX_VER}
RUN apt-get update && \
  DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
    libasound2-dev \
    libopus-dev \
    libortp-dev
RUN PREFIX=/trx make install

FROM debian:buster AS runtime

LABEL org.opencontainers.image.source https://github.com/hairyhenderson/dockerfiles

COPY --from=build /trx/bin/* /bin/

RUN apt-get update && \
  DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
    libasound2 \
    libopus0 \
    libortp13 \
    libasound2-plugins alsa-utils opus-tools \
    zlib1g \
    gzip>=1.9-3+deb10u1 \
    liblzma5>=5.2.4-1+deb10u1 \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*
