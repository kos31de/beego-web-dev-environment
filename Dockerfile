FROM golang:1.14.1-alpine

RUN apk --update --no-cache add shadow busybox-suid alpine-sdk mysql-client tzdata less
RUN export GO111MODULE=on && go get -u github.com/beego/bee

RUN mkdir /beego-web-dev-environment
WORKDIR /beego-web-dev-environment

COPY go.mod .
COPY go.sum .
RUN go mod download

RUN touch .env

COPY . .
RUN go build

EXPOSE 8080
CMD ./beego-web-dev-environment
