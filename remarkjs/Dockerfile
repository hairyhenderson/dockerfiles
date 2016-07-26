FROM nginx:1-alpine

# install gomplate
ENV GOMPLATE_VER v1.0.0
ADD https://github.com/hairyhenderson/gomplate/releases/download/$GOMPLATE_VER/gomplate_linux-amd64-slim /usr/local/bin/gomplate
RUN chmod a+rx /usr/local/bin/gomplate

ENV TITLE My Title

COPY index.html.tmpl /
COPY docker-entrypoint.sh /

ENTRYPOINT [ "/docker-entrypoint.sh" ]

CMD ["-g", "daemon off;"]
