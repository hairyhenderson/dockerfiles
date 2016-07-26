# hairyhenderson/remarkjs

nginx-based hosting for _external_ [remarkjs] slides.

## Usage

- mount your remark-formatted slides file to `/slides.md`

```console
$ docker run -d -p 8080:80 -v $(pwd)/slides.md:/slides.md hairyhenderson/remarkjs
$ open http://localhost:8080
```

[remarkjs]: http://remarkjs.com/#1
