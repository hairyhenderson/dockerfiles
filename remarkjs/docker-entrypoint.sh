#!/bin/ash
set -e

if [ "${1:0:1}" = '-' ]; then
  set -- nginx "$@"
fi

if [ "$1" = 'nginx' ]; then
  WEBROOT=/usr/share/nginx/html
  gomplate < /index.html.tmpl > $WEBROOT/index.html
  if [ -f /slides.md.tmpl ]; then
    gomplate < /slides.md.tmpl > $WEBROOT/slides.md
  else
    cp /slides.md $WEBROOT/slides.md
  fi
fi

exec "$@"
