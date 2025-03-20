# Docker image with Golang and Beego

Base image for Beego
- [jetbrainsinfra/golang](https://github.com/jetbrains-infra/docker-image-golang)

Beego package included
- github.com/astaxie/beego
- github.com/beego/bee
- gopkg.in/mgo.v2/bson
- github.com/dgrijalva/jwt-go
- github.com/garyburd/redigo/redis

Network Dev : for local development
```
#Docker create dev network
docker network create -d bridge --subnet 172.18.0.0/16 \
--gateway=172.18.0.1 \
--opt com.docker.network.bridge.enable_icc=true \
--opt com.docker.network.bridge.enable_ip_masquerade=true \
--opt com.docker.network.bridge.host_binding_ipv4=0.0.0.0 \
--opt com.docker.network.driver.mtu=1500 \
dev
```
