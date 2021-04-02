FROM golang:1.16-alpine as build

ENV CGO_ENABLED=0
RUN go get github.com/docker/swarmkit/cmd/swarm-rafttool
RUN go get github.com/docker/swarmkit/cmd/swarmctl

FROM alpine:3.13

COPY --from=build /go/bin/swarmctl /bin/swarmctl
COPY --from=build /go/bin/swarm-rafttool /bin/swarm-rafttool
