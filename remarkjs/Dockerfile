FROM hairyhenderson/gomplate:v3.11.0 AS gomplate

FROM nginx:1-alpine

ENV REMARK_VER 0.14.1
ENV WEBROOT /usr/share/nginx/html
ENV TITLE My Title
ENV RATIO 4:3
ENV HIGHLIGHT_LINES false
ENV HIGHLIGHT_STYLE default

# updates to workaround CVEs
RUN apk add -u --no-cache \
    curl>=7.80.0-r1 \
    libxml2>=2.9.14-r0 \
    freetype>=2.11.1-r1

ADD https://gnab.github.io/remark/downloads/remark-${REMARK_VER}.min.js /usr/share/nginx/html/
RUN chmod a+r /usr/share/nginx/html/remark-${REMARK_VER}.min.js

COPY styles.css $WEBROOT
COPY index.html.tmpl /
COPY docker-entrypoint.sh /

COPY --from=gomplate /gomplate /usr/local/bin/gomplate

ENTRYPOINT [ "/docker-entrypoint.sh" ]

CMD ["-g", "daemon off;"]
