#!/usr/bin/env bash
mkdir -p out/log
export PACKER_LOG_PATH=out/log/$1.log
export PACKER_LOG=1
