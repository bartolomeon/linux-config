#!/bin/bash

die() { echo "Error: $@" 1>&2 ; exit 1; }

[ ! -z "$1" ] || die "Missing argument - docker name/ID"

CONTAINER_NAME_OR_ID=$1

DOCKER_IP=`docker inspect $CONTAINER_NAME_OR_ID | grep '"IPAddress"' | head -n 1 | sed -e 's/^.*"\([0-9]\+\.[0-9]\+\.[0-9]\+\.[0-9]\+\)\".*/\1/g'`

echo $DOCKER_IP
 
