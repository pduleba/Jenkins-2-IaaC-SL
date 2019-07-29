#!/bin/bash

# ------ Documentation ------
# https://aws.amazon.com/getting-started/projects/setup-jenkins-build-server/
# ------ ------ ------ ------

# Enable user-data execution logging # https://aws.amazon.com/premiumsupport/knowledge-center/ec2-linux-log-user-data/
exec > >(tee /var/log/user-data.log|logger -t user-data -s 2>/dev/console) 2>&1

# Mount EBS (Jenkins Storage)
sudo vgchange -ay
if [[ -z $(blkid -o value -s TYPE ${EBS_DEVICE}) ]] ; then
  # Wait for EBS availability
  while [[ ! -b ${EBS_DEVICE} ]]; do
    "EBS not available yet"
    sleep 5
  done

  # Format EBS
  sudo mkfs.ext4 ${EBS_DEVICE}
fi
sudo mkdir -p /var/lib/jenkins-backup
sudo mount ${EBS_DEVICE} /var/lib/jenkins-backup
# https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ebs-using-volumes.html#ebs-mount-after-reboot
echo "${EBS_DEVICE} /var/lib/jenkins-backup ext4 defaults,nofail 0 2" >> /etc/fstab
sudo chmod 755 /var/lib/jenkins-backup
sudo chown jenkins:jenkins /var/lib/jenkins-backup

sudo systemctl stop jenkins

sudo rsync -aq /var/lib/jenkins/* /var/lib/jenkins-backup
sudo rm -rf /var/lib/jenkins
sudo ln -s /var/lib/jenkins-backup /var/lib/jenkins

sudo systemctl start jenkins
sudo systemctl start docker