FROM debian:trixie

ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get install -y \
    freeciv-server \
    && apt-get clean --yes \
    && rm -rf /var/lib/apt/lists/*

RUN useradd -m freeciv

USER freeciv
WORKDIR /home/freeciv

ENTRYPOINT [ "/usr/games/freeciv-server" ]
