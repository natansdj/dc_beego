ARG GO_VERSION=1.11

#Base image is in https://registry.hub.docker.com/_/golang/
#Refer to https://blog.golang.org/docker for usage
# FROM golang:${GO_VERSION}

ARG GLIDE_VERSION=0.12.3
ARG DEP_VERSION=0.5.0

FROM jetbrainsinfra/golang:${GO_VERSION}

ENV GOPATH /go

# Install beego & bee
RUN go get github.com/astaxie/beego
RUN go get github.com/beego/bee
RUN go get gopkg.in/mgo.v2/bson
RUN go get github.com/dgrijalva/jwt-go
RUN go get github.com/garyburd/redigo/redis
