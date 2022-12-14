FROM hairyhenderson/gomplate:v3 AS gomplate

FROM nginx:1.23.3-alpine

ENV REMARK_VER 0.14.1
ENV WEBROOT /usr/share/nginx/html
ENV TITLE My Title
ENV RATIO 4:3
ENV HIGHLIGHT_LINES false
ENV HIGHLIGHT_STYLE default

# updates to workaround CVEs
RUN apk add -u --no-cache \
    curl>=7.83.1-r4 # CVE-2022-42915 CVE-2022-42916

ADD https://gnab.github.io/remark/downloads/remark-${REMARK_VER}.min.js /usr/share/nginx/html/
RUN chmod a+r /usr/share/nginx/html/remark-${REMARK_VER}.min.js

COPY styles.css $WEBROOT
COPY index.html.tmpl /
COPY docker-entrypoint.sh /

COPY --from=gomplate /gomplate /usr/local/bin/gomplate

ENTRYPOINT [ "/docker-entrypoint.sh" ]

CMD ["-g", "daemon off;"]
