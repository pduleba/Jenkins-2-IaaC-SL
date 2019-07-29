#!/usr/bin/env bash
mkdir -p out/$1/log
export TF_LOG_PATH=out/$1/log/$2.log
export TF_LOG=DEBUG
