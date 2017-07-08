#!/bin/ash

set -e

if [ "${1:0:1}" = '-' ]; then
	set -- caddy "$@"
fi

if [ "$1" = 'caddy' ]; then
	gomplate -f /srv/Caddyfile.tmpl -o /srv/Caddyfile
fi

exec "$@"
