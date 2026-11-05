FROM debian:trixie@sha256:2dc419c6d7fe3dad0a2f9fd469c34cc90b0f9ba642d8fde837fe3d7d34a0e7f1

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
