Use like this:

```console
$ export FQDN=my.domain.name
$ export TLS_CONFIG=my@email.address
$ docker run -d -p 80:80 -p 443:443 -e FQDN -e TLS_CONFIG hairyhenderson/caddyproxy
```
