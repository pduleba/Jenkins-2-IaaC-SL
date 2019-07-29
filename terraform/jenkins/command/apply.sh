#!/usr/bin/env bash
cd ./infrastructure/$1
. ./../../command/utils/session-start.sh $2 apply
terraform apply \
    -input=false \
    -state="out/$2/state.tfstate" \
    out/$2/apply-plan.tfplan
. ./../../command/utils/session-stop.sh
cd ./../..