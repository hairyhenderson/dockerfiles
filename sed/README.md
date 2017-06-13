# hairyhenderson/sed

Just GNU `sed` in a container...

Use like this:

```console
$ echo "hi world" | docker run --rm -i hairyhenderson/sed 's/i/ello/'
hello world
```

Or with an alias:

```bash
alias sed='docker run --rm -i hairyhenderson/sed'
```

```console
$ echo "hi world" | sed 's/i/ello/'
hello world
```
