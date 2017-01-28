#!/bin/ash

set -e

if [ "${1:0:1}" = '-' ]; then
	set -- caddy "$@"
fi

if [ "$1" = 'caddy' ]; then
	gomplate < /srv/Caddyfile.tmpl > /srv/Caddyfile
fi

exec "$@"
