FROM alpine:3.8
LABEL maintainer "dhenderson@gmail.com"

RUN apk add --no-cache tar curl ca-certificates \
  && curl --silent --show-error --fail --location \
      --header "Accept: application/tar+gzip, application/x-gzip, application/octet-stream" -o - \
      "https://caddyserver.com/download/linux/amd64?plugins=http.prometheus" \
    | tar --no-same-owner -C /usr/bin/ -xz caddy \
  && curl --silent --show-error --fail --location -o /usr/local/bin/gomplate \
    https://github.com/hairyhenderson/gomplate/releases/download/v1.9.1/gomplate_linux-amd64-slim \
  && apk del --no-cache tar curl \
  && chmod 0755 /usr/bin/caddy \
  && chmod 0755 /usr/local/bin/gomplate \
  && caddy -version \
  && gomplate --version

EXPOSE 80 443
WORKDIR /srv

COPY docker-entrypoint.sh /srv/docker-entrypoint.sh
COPY Caddyfile.tmpl /srv/Caddyfile.tmpl

ENTRYPOINT ["./docker-entrypoint.sh"]
CMD ["caddy"]
