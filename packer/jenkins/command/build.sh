#!/usr/bin/env bash
. ./command/utils/session-start.sh build
packer build \
    -var-file="./config/global.json" \
    $1
. ./command/utils/session-stop.sh
