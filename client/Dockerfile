FROM golang:1.11.2-alpine
RUN mkdir /app
ADD . /app/
WORKDIR /app
RUN go build -o main .
ENTRYPOINT ["/app/main"]