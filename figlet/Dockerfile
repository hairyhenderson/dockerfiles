FROM alpine

RUN apk update \
  && apk add figlet \
  && rm -rf /var/cache/apk/*

ENTRYPOINT ["figlet"]
