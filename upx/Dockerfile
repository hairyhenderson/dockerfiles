FROM alpine:3.11.5

# install 3.94 until 3.96 is released. 3.95 has a bug!
RUN apk add --no-cache upx=3.94-r0

ENTRYPOINT [ "/usr/bin/upx" ]
