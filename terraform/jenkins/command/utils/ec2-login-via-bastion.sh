#!/usr/bin/env bash
ssh \
	-At \
	ec2-user@$1 \
	ssh ec2-user@$2