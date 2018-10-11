FROM alpine

ENV PAGER /usr/bin/less
RUN apk add --no-cache man man-pages util-linux-doc e2fsprogs-doc

USER 42000:42000

ENTRYPOINT ["man"]
