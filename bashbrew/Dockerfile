FROM alpine:3.21

LABEL org.opencontainers.image.source=https://github.com/hairyhenderson/dockerfiles

RUN set -eux; \
	apkArch="$(apk --print-arch)"; \
	case "$apkArch" in \
		x86)		binArch='i386' ;; \
		x86_64)		binArch='amd64' ;; \
		armhf)		binArch='arm32v6' ;; \
		armv7)		binArch='arm32v7' ;; \
		aarch64)	binArch='arm64v8' ;; \
		*) echo >&2 "error: unsupported architecture ($apkArch)"; exit 1 ;;\
	esac; \
	wget -O /bin/bashbrew https://doi-janky.infosiftr.net/job/bashbrew/job/master/lastSuccessfulBuild/artifact/bashbrew-${binArch}; \
	chmod 755 /bin/bashbrew

CMD [ "/bin/bashbrew" ]
