#!/usr/bin/env bash
cd ./infrastructure/$1
. ./../../command/utils/session-start.sh $2 destroy-plan
terraform fmt . > out/$2/log/fmt.log
terraform plan \
    -input=false \
    -var-file="./../../config/global.tfvars" \
    -var-file="./../../config/env/$2/$1.tfvars" \
    -state="out/$2/state.tfstate" \
    -out="out/$2/destroy-plan.tfplan" \
    -destroy \
    .
. ./../../command/utils/session-stop.sh
cd ./../..