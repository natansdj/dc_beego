###
# Docker image
# natansdj/go-beego
###
ARG GO_VERSION=1.14

#Base image is in https://registry.hub.docker.com/_/golang/
#Refer to https://blog.golang.org/docker for usage
FROM golang:${GO_VERSION}

ARG GLIDE_VERSION=0.13.3
ARG DEP_VERSION=0.5.0

# FROM jetbrainsinfra/golang:${GO_VERSION}
RUN mkdir -p /opt/glide \
 && wget -nv https://github.com/Masterminds/glide/releases/download/v$GLIDE_VERSION/glide-v$GLIDE_VERSION-linux-amd64.tar.gz -O- | \
    tar xzf - -C /opt/glide --strip-components=1 \
 && mv /opt/glide/glide /usr/local/bin/ \
 && go get github.com/sparrc/gdm \
 && go get github.com/2tvenom/go-test-teamcity \
 && wget -nv https://github.com/golang/dep/releases/download/v$DEP_VERSION/dep-linux-amd64 -O /usr/local/bin/dep \
 && chmod +x /usr/local/bin/dep

ENV GOPATH /go

# Install beego & bee
RUN go get github.com/astaxie/beego
RUN export GO111MODULE=on && go get -u github.com/beego/bee
RUN go get gopkg.in/mgo.v2/bson
RUN go get github.com/dgrijalva/jwt-go
RUN go get github.com/garyburd/redigo/redis
RUN go get github.com/go-delve/delve/cmd/dlv
