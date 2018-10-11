FROM alpine

ENV PAGER /usr/bin/less
RUN apk add --no-cache man man-pages
RUN apk add --no-cache util-linux-doc
RUN apk add --no-cache e2fsprogs-doc

USER 42000:42000

ENTRYPOINT ["man"]
