FROM debian:trixie@sha256:913f6706df59a68922d1dd08f78c2476560a8d367897200a6005b00e5f67c2d5

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
