#!/usr/bin/env bash
cd ./infrastructure/$1
. ./../../command/utils/session-start.sh $2 apply-plan
terraform fmt . > out/$2/log/fmt.log
terraform plan \
    -input=false \
    -var-file="./../../config/global.tfvars" \
    -var-file="./../../config/env/$2/$1.tfvars" \
    -state="out/$2/state.tfstate" \
    -out="out/$2/apply-plan.tfplan" \
    .
. ./../../command/utils/session-stop.sh
cd ./../..