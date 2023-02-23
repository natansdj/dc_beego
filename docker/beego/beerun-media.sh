#!/bin/bash

#
if [ -z "$GO_SVC" ]
then
  echo "Empty GO_SVC!!!"
  exit 1
fi

WORKDIR="/go/src/$GO_SVC"
MYTIMEOUT=20s

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

#
build() {
  echo "## building..."
  # $GOBIN/bee run & (sleep "$MYTIMEOUT"; kill $! ) & wait
  CGO_ENABLED=1 GOOS=linux GOARCH=amd64 go build -o ${GO_SVC}
}

#
if [ "$DDC_ENV" == 'local' ] || [ "$DDC_ENV" == 'dev' ] || [ "$DDC_ENV" == 'staging' ] || [ "$DDC_ENV" == 'prod' ]; then
  echo "## change runmode to dev..."
  sed -i 's/runmode = prod/runmode = dev/' conf/app.conf
  $GOBIN/bee run & (sleep "$MYTIMEOUT"; kill $! ) & wait
fi

if [ "$DDC_ENV" == "prod" ]; then
  echo "## change runmode to prod..."
  sudo sed -i 's/runmode = dev/runmode = prod/' conf/app.conf
  # $GOBIN/bee run & (sleep "$MYTIMEOUT"; kill -9 $! ) & wait
fi

#
if [ -z "$DOCKER_UID" ]; then
  echo "## empty DOCKER_UID skip atribute update..."
else
  echo "## update file & folder attributes"
  chown -R ${DOCKER_UID}:${DOCKER_GID} .
fi

#
echo "## build & start go service"
build

#
echo "## run ${GO_SVC}"
sleep 2147483647 | ./${GO_SVC}
