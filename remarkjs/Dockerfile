FROM qlik/node-build AS remark

WORKDIR /src
RUN wget -q -O /tmp/develop.zip https://github.com/gnab/remark/archive/develop.zip
RUN unzip /tmp/develop.zip
RUN mv /src/remark-develop /src/remark
WORKDIR /src/remark
RUN make deps highlighter bundle && exit 1

FROM nginx:alpine

ENV WEBROOT /usr/share/nginx/html
ENV TITLE My Title
ENV RATIO 4:3
ENV HIGHLIGHT_LINES false
ENV HIGHLIGHT_STYLE default

COPY --from=hairyhenderson/gomplate:slim /gomplate /usr/local/bin/gomplate

ADD https://gnab.github.io/remark/downloads/remark-${REMARK_VER}.min.js /usr/share/nginx/html/
RUN chmod a+r /usr/share/nginx/html/remark-${REMARK_VER}.min.js
COPY styles.css $WEBROOT
COPY index.html.tmpl /
COPY docker-entrypoint.sh /

ENTRYPOINT [ "/docker-entrypoint.sh" ]

CMD ["-g", "daemon off;"]
