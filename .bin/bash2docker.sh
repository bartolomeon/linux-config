#!/bin/bash

die() { echo "Error: $@" 1>&2 ; exit 1; }

[ ! -z "$1" ] || die "Missing argument - docker name/ID"

CONTAINER_NAME_OR_ID=$1

docker exec -i -t $CONTAINER_NAME_OR_ID bash

