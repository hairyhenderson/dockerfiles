FROM alpine:3.11.5

RUN apk add --no-cache curl

RUN curl -SLo /bin/bashbrew https://doi-janky.infosiftr.net/job/bashbrew/lastSuccessfulBuild/artifact/bin/bashbrew-amd64
RUN chmod 755 bin/bashbrew

CMD [ "/bin/bashbrew" ]
