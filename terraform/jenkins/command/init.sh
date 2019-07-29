#!/usr/bin/env bash
cd ./infrastructure/$1
. ./../../command/utils/session-start.sh $2 init
options=
if [[ "$1" != "backend" ]] ; then
    options=-backend-config="./../../config/global.tfvars"\ -backend-config="key=$2/$1.tfstate"
fi
# https://www.terraform.io/docs/backends/config.html
terraform init \
    $options \
    .
. ./../../command/utils/session-stop.sh
cd ./../..