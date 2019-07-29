#!/bin/bash

# Enable user-data execution logging # https://aws.amazon.com/premiumsupport/knowledge-center/ec2-linux-log-user-data/
exec > >(tee /var/log/user-data.log|logger -t user-data -s 2>/dev/console) 2>&1

# Update
sudo yum update -y

# Tools
sudo yum install wget curl jq nc zip -y

# Customization
sudo echo "export PS1='\[\e[1;31m\]\u@\h\[\e[0m\]:\[\e[1;34m\]\W\[\e[0m\]$\[\e[0m\] '" >> ~/.bashrc
sudo echo "export PS1='\[\e[1;32m\]\u@\h\[\e[0m\]:\[\e[1;34m\]\W\[\e[0m\]$\[\e[0m\] '" >> /home/ec2-user/.bashrc