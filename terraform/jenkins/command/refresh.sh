#!/usr/bin/env bash
cd ./infrastructure/$1
. ./../../command/utils/session-start.sh $2 refresh
terraform refresh \
    -input=false \
    -var-file="./../../config/global.tfvars" \
    -var-file="./../../config/env/$2/$1.tfvars" \
    -state="out/$2/state.tfstate" \
    .
. ./../../command/utils/session-stop.sh
cd ./../..