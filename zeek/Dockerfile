FROM debian:stretch as builder

RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
      build-essential \
      git \
      bison \
      flex \
      gawk \
      cmake \
      swig \
      libssl1.0-dev \
      libmaxminddb-dev \
      libpcap-dev \
      python-dev \
      libcurl4-openssl-dev \
      wget \
      libncurses5-dev \
      ca-certificates \
      zlib1g-dev

# Build bro
WORKDIR /usr/src/

ARG VER=2.6.1

RUN wget -q http://www.zeek.org/downloads/bro-${VER}.tar.gz
RUN tar zxf bro-${VER}.tar.gz
WORKDIR /usr/src/bro-${VER}
RUN ./configure --prefix=/usr/local/zeek
RUN make -j4 install

# get geoip data

FROM debian:stretch as geogetter

RUN apt-get update 
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install --no-install-recommends \
  wget \
  ca-certificates 

RUN mkdir -p /usr/share/GeoIP/
RUN wget -q http://geolite.maxmind.com/download/geoip/database/GeoLite2-City.tar.gz
RUN tar zxf GeoLite2-City.tar.gz
RUN wget -q http://geolite.maxmind.com/download/geoip/database/GeoLite2-ASN.tar.gz
RUN tar zxf GeoLite2-ASN.tar.gz
RUN mv */*.mmdb /usr/share/GeoIP

# Make final image
FROM debian:stretch AS zeek

#install runtime dependencies
RUN apt-get update \
    && apt-get -y install --no-install-recommends \
      libpcap0.8 \
      libssl1.0.2 \
      libmaxminddb0 \
      python2.7-minimal \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*
RUN ln -s /usr/bin/python2.7 /usr/bin/python

COPY --from=builder /usr/local/zeek /usr/local/zeek
COPY --from=geogetter /usr/share/GeoIP/* /usr/share/GeoIP/
COPY ./zeek_profile.sh /etc/profile.d/zeek.sh

ENV PATH=/usr/local/zeek/bin/:$PATH

CMD ["/bin/bash", "-l"]
