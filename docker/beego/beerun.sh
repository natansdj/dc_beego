#!/bin/sh

WORKDIR="/go/src/${GO_SVC}"

#
if [ -z "$WORKDIR" ]; then
    echo "Empty WORKDIR!!!"
    exit 1
fi

#
cd ${WORKDIR}
echo "WORKDIR : ${WORKDIR}"

#
if [ -z "$GO_SVC" ]
then
  echo "Empty GO_SVC!!!"
  exit 1
else
  echo "GO_SVC : ${GO_SVC}"
  CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build && ./${GO_SVC}
fi
