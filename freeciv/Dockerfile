FROM debian:trixie

ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get install -y \
    freeciv-server \
    && apt-get clean --yes \
    && rm -rf /var/lib/apt/lists/*

RUN useradd -m freeciv

USER freeciv
WORKDIR /home/freeciv
VOLUME /data

ENV FREECIV_SAVE_PATH=/data

ENTRYPOINT [ "/usr/games/freeciv-server", "--saves=/data" ]
