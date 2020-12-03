FROM golang:alpine3.12 as golang
WORKDIR /go/src/app
COPY app.go /go/src/app

#disable crosscompiling 
ENV CGO_ENABLED=0

#build the binary with debug information removed
RUN go build  -ldflags '-w -s' -a -installsuffix cgo -o /go/bin/app
#RUN CGO_ENABLED=0 go build  -ldflags '-w -s' -a -installsuffix cgo -o /go/bin/app

FROM scratch
# the test program:
COPY --from=golang /go/bin/app /app
# the timezone data:
ENTRYPOINT ["/app"]