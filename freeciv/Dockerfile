FROM debian:trixie@sha256:f324c7ff54321e8d9c588493a20244965938ce0aa50bbd1022d38010e9ffc4b1

ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get install --yes \
    freeciv-server \
    && apt-get upgrade --yes \
    && apt-get clean --yes \
    && rm -rf /var/lib/apt/lists/*

RUN useradd -m freeciv

USER freeciv
WORKDIR /home/freeciv
VOLUME /data

ENV FREECIV_SAVE_PATH=/data

ENTRYPOINT [ "/usr/games/freeciv-server", "--saves=/data" ]
