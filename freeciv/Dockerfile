FROM debian:trixie@sha256:4c25275446ca371766b8b093c696782eabce06263fccacb8d5d813b3dc44b308

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
