# IaaC for `app-rest`

## Usage

* `command/init MODULE ENV` - Initialize Terraform `MODULE` using `ENV` configuration 
  * i.e. `command/init.sh network dev`
* `command/apply-plan MODULE ENV` - Provides apply plan file
  * i.e. `command/apply-plan.sh network dev`
* `command/apply MODULE ENV` - Apply Terraform `MODULE` using `ENV` configuration 
  * i.e. `command/apply.sh network dev`
* `command/destroy-plan MODULE ENV` - Provides destroy plan file `MODULE` using `ENV` configuration
  * i.e. `command/destroy-plan.sh network dev`
* `command/destroy MODULE ENV` - Destroy `MODULE` infrastructure using `ENV` configuration 
  * i.e. `command/destroy.sh network dev`
  
* `command/refresh.sh MODULE ENV` - Refresh Terraform state of `MODULE` using `ENV` configuration 
  * i.e. `command/refresh.sh backend dev`

## Utils
  
* `command/utils/session-start.sh MODULE ENV LOG_NAME` - Utility :: Starts execution recording
* `command/utils/session-stop.sh` - Utility :: Stops execution recording

* `command/utils/ssh-init.sh path/path/KEY_PAIR_PEM` - Initialize `ssh-agent` and adds PEM key pair using `ssh-add` 
  * i.e. `. command/utils/ssh-init.sh key.pem`
  * IMPORTANT - it has to be run in current shell process (use `.` before script)
* `command/utils/ec2-login.sh INSTANCE_IP` - Connects to instance in public subnet
* `command/utils/ec2-login-via-bastion.sh BASTION_IP PRIVATE_IP` - Connects to instance in private subnet via bastion instance in public subnet 
* `ssh-agent -k` - kill current `ssh-agent`

## Documentation
* [Terraform](https://www.terraform.io/docs/index.html)
* [About ssh-agent and ssh-add in Unix](https://kb.iu.edu/d/aeww)
* [Securely Connect to Linux Instances Running in a Private Amazon VPC](https://aws.amazon.com/blogs/security/securely-connect-to-linux-instances-running-in-a-private-amazon-vpc/)
* [Connect To The Application Instance Using SSH](https://docs.bitnami.com/aws-templates/infrastructure/lamp-production-ready/get-started/connect-ssh/)