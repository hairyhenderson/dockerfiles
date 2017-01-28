# hairyhenderson/caddyproxy

A [Caddy](https://caddyserver.com) image to be used as a simple proxy.

Configure with environment variables.

Use like this:

```console
$ export FQDN=my.domain.name
$ export TLS_CONFIG=my@email.address
$ export PROXY_DEST=http://destination.site:1234/foo/bar
$ docker run -d -p 80:80 -p 443:443 -e FQDN -e TLS_CONFIG hairyhenderson/caddyproxy
```
