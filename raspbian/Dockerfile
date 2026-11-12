FROM debian:13@sha256:9c6e381421d0f48d1b8133e573f33c185ee16cbf505eda9c4a8a4791b25ea8a6 AS build

ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update
RUN apt-get install -y --no-install-recommends \
    gnupg \
    liblz4-1

ADD https://archive.raspbian.org/raspbian.public.key /tmp/raspbian.public.key
ADD https://archive.raspberrypi.org/debian/raspberrypi.gpg.key /tmp/raspberrypi.gpg.key
RUN apt-key add /tmp/raspbian.public.key
RUN apt-key add /tmp/raspberrypi.gpg.key

RUN apt-get purge --auto-remove -y gnupg

RUN echo "deb http://raspbian.raspberrypi.org/raspbian/ buster main contrib non-free rpi" > /etc/apt/sources.list
RUN echo "deb http://archive.raspberrypi.org/debian/ buster main ui" > /etc/apt/sources.list.d/raspi.list

RUN apt-get update
RUN apt-get dist-upgrade -y --no-install-recommends

RUN rm -rf /var/lib/apt/lists/*
RUN rm -rf /var/cache/apt/*
RUN rm -f /tmp/raspbian.public.key

FROM scratch AS raspbian

LABEL org.opencontainers.image.source=https://github.com/hairyhenderson/dockerfiles

COPY --from=build / /
CMD ["bash"]
