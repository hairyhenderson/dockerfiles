FROM alpine:3.11 AS get-caddy

ADD https://caddyserver.com/download/linux/amd64?plugins=http.prometheus&license=personal&telemetry=on /caddy.tar.gz

FROM alpine:3.11 AS caddy

RUN apk add --no-cache tar 

COPY --from=get-caddy /caddy.tar.gz /caddy.tar.gz

RUN tar --no-same-owner -C /usr/bin/ -zxf /caddy.tar.gz caddy
RUN chmod 0755 /usr/bin/caddy
RUN caddy -version

FROM alpine:3.11

LABEL maintainer "dhenderson@gmail.com"

EXPOSE 80 443
WORKDIR /srv

COPY docker-entrypoint.sh /srv/docker-entrypoint.sh
COPY Caddyfile.tmpl /srv/Caddyfile.tmpl

COPY --from=hairyhenderson/gomplate:slim /gomplate /usr/local/bin/gomplate
COPY --from=caddy /usr/bin/caddy /usr/bin/caddy

ENTRYPOINT ["./docker-entrypoint.sh"]
CMD ["caddy"]
