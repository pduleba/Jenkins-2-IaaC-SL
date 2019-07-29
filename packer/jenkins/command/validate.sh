#!/usr/bin/env bash
. ./command/utils/session-start.sh validate
packer validate \
    -var-file="./config/global.json" \
    $1
. ./command/utils/session-stop.sh
