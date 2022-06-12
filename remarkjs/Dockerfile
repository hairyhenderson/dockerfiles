FROM hairyhenderson/gomplate:v3.11.0 AS gomplate

FROM nginx:1.22-alpine

ENV REMARK_VER 0.14.1
ENV WEBROOT /usr/share/nginx/html
ENV TITLE My Title
ENV RATIO 4:3
ENV HIGHLIGHT_LINES false
ENV HIGHLIGHT_STYLE default

# updates to workaround CVEs
RUN apk add -u --no-cache \
    pcre2>=10.40-r0 # CVE-2022-1586, CVE-2022-1587

ADD https://gnab.github.io/remark/downloads/remark-${REMARK_VER}.min.js /usr/share/nginx/html/
RUN chmod a+r /usr/share/nginx/html/remark-${REMARK_VER}.min.js

COPY styles.css $WEBROOT
COPY index.html.tmpl /
COPY docker-entrypoint.sh /

COPY --from=gomplate /gomplate /usr/local/bin/gomplate

ENTRYPOINT [ "/docker-entrypoint.sh" ]

CMD ["-g", "daemon off;"]
