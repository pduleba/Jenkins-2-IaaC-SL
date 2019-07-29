#!/bin/sh
echo Running SSH-AGENT
eval `ssh-agent`
echo Running SSH-ADD
ssh-add $1
echo Init exit code $? of PID $$ shell
