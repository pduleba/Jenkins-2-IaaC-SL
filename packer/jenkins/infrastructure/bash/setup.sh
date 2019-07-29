#!/usr/bin/env bash

# Update
sudo yum update -y

# Tools
sudo yum install wget curl jq nc zip git ruby rsync -y

# https://www.terraform.io/docs/index.html
sudo echo "Terraform installation"
sudo wget -q -O ~/terraform_0.12.3_linux_amd64.zip https://releases.hashicorp.com/terraform/0.12.3/terraform_0.12.3_linux_amd64.zip
sudo unzip ~/terraform_0.12.3_linux_amd64.zip -d /usr/bin/
sudo rm -rf ~/terraform_0.12.3_linux_amd64.zip

# https://www.packer.io/docs/
sudo echo "Packer installation"
sudo wget -q -O ~/packer_1.4.2_linux_amd64.zip https://releases.hashicorp.com/packer/1.4.2/packer_1.4.2_linux_amd64.zip
sudo unzip ~/packer_1.4.2_linux_amd64.zip -d /usr/bin/
sudo rm -rf ~/packer_1.4.2_linux_amd64.zip

# https://docs.aws.amazon.com/AmazonECS/latest/developerguide/docker-basics.html
sudo echo "Docker installation"
sudo amazon-linux-extras install docker
sudo usermod -a -G docker ec2-user
sudo chkconfig jenkins on
sudo systemctl start docker

# https://openjdk.java.net/install/
sudo echo "JDK installation"
sudo yum install java-1.8.0-openjdk-devel -y
sudo echo JAVA_HOME="$(dirname "$(dirname "$(readlink -f "$(which javac || which java)")")")" >> /etc/environment
source /etc/environment

# http://pkg.jenkins-ci.org/redhat/
sudo echo "Jenkins installation"
sudo wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat/jenkins.repo
sudo rpm --import https://pkg.jenkins.io/redhat/jenkins.io.key
sudo yum install jenkins -y
sudo echo JENKINS_HOME=/var/lib/jenkins >> /etc/environment
sudo chkconfig jenkins on

sudo echo "Jenkins configuration"
sudo mkdir -p /var/lib/jenkins/init.groovy.d
sudo mv /tmp/groovy/*.groovy /var/lib/jenkins/init.groovy.d
sudo chown jenkins:jenkins /var/lib/jenkins/init.groovy.d -R
sudo chmod +x /tmp/bash/install-plugins.sh
sudo bash /tmp/bash/install-plugins.sh

sudo systemctl start jenkins
# cat /var/log/jenkins/jenkins.log
# cat /var/lib/jenkins/secrets/initialAdminPassword

sudo echo "Customization"
sudo echo "export PS1='\[\e[1;31m\]\u@\h\[\e[0m\]:\[\e[1;34m\]\W\[\e[0m\]$\[\e[0m\] '" >> ~/.bashrc
sudo echo "export PS1='\[\e[1;32m\]\u@\h\[\e[0m\]:\[\e[1;34m\]\W\[\e[0m\]$\[\e[0m\] '" >> /home/ec2-user/.bashrc