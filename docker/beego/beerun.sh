#!/bin/bash
#
if [ -z "$GO_SVC" ]
then
  echo "Empty GO_SVC!!!"
  exit 1
fi

#
WORKDIR="/go/src/${GO_SVC}"

#
if [ -z "$WORKDIR" ]; then
    echo "Empty WORKDIR!!!"
    exit 1
fi

if [ -z "$GOBIN" ]; then
    GOBIN=$GOPATH/bin
fi

if [ -z "$DDC_ENV" ]; then
    DDC_ENV="dev"
fi

#
cd ${WORKDIR}
echo "WORKDIR : ${WORKDIR}"
echo "GO_SVC : ${GO_SVC}"
echo "DDC_ENV : ${DDC_ENV}"

echo "## go mod..."
go mod download
go mod vendor

if [ -z "$DOCKER_UID" ]; then
  echo "## empty DOCKER_UID skip atribute update..."
else
  echo "## update file & folder attributes"
  chown -R ${DOCKER_UID}:${DOCKER_GID} .
fi

#
if [ "$DDC_ENV" == "local" ]; then
  echo "## build & watch"
  # $GOBIN/bee run
  CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build && ./${GO_SVC}
elif [ "$DDC_ENV" == "dev" ] || [ "$DDC_ENV" == "staging" ]; then
  echo "## build & start go service"
  CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build && ./${GO_SVC}
else
  echo "## start go service"
  ./${GO_SVC}
fi
