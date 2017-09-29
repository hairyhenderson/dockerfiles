FROM buildpack-deps:stretch AS build

RUN mkdir /src
WORKDIR /src
RUN curl -sSLO http://www.pogo.org.uk/%7Emark/trx/releases/trx-0.2.tar.gz
RUN tar zxf trx-0.2.tar.gz

WORKDIR /src/trx-0.2
RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
  libasound2-dev \
  libopus-dev \
  libortp-dev
RUN PREFIX=/trx make install

FROM debian:stretch AS runtime

COPY --from=build /trx/bin/* /bin/

RUN apt-get update && \
  DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
    libasound2 \
    libopus0 \
    libortp9 \
    libasound2-plugins alsa-utils opus-tools \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*
