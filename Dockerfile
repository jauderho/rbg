FROM golang:1.22.3-alpine3.20@sha256:1b455a3f7786e5765dbeb4f7ab32a36cdc0c3f4ddd35406606df612dc6e3269b AS build

RUN mkdir /app
COPY . /app

RUN apk add gcc musl-dev && cd /app && GOAMD64=v3 go build -trimpath -ldflags="-s -w" -o rbg .


###


FROM alpine:3.20.0@sha256:77726ef6b57ddf65bb551896826ec38bc3e53f75cdde31354fbffb4f25238ebd

COPY --from=build /app/rbg /rbg
COPY ./trackers.txt /trackers.txt

ENTRYPOINT ["/rbg"]

