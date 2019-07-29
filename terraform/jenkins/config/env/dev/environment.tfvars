##################################################################################
# VARIABLES
##################################################################################

vpc_name_postfix            = "vpc"
public_subnet_name_postfix  = "public-subnet"
private_subnet_name_postfix = "private-subnet"

ec2_type                        = "t3.small"
ec2_key_pair_name_postfix       = "key-pair"
ec2_user_data_template_path     = "./../../config/templates/jenkins_user_data.tpl"
ec2_security_group_name_postfix = "jenkins-sg"
ec2_ebs_root_type               = "gp2"
ec2_ebs_root_size               = 50
ec2_ebs_root_tag_name_postfix   = "root-ebs"
# https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/device_naming.html#available-ec2-device-names
ec2_ebs_attached_device_name      = "/dev/sdf"
ec2_ebs_attached_skip_destroy     = true
ec2_ebs_attached_tag_name_postfix = "storage-ebs"

ec2_filter_owners = ["self"]
ec2_filter_names  = ["pduleba-jenkins-golden-ami"]

ssm_policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2RoleforSSM"

alb_protocol                              = "HTTP"
alb_port                                  = "8080"
alb_security_group_name_postfix           = "alb-sg"
alb_listener_default_action_redirect_path = "/"
alb_listener_rule_condition_values        = ["/*"]

target_group_path                 = "/"
target_group_slow_start           = 300
target_group_deregistration_delay = 300

# https://docs.aws.amazon.com/console/elasticloadbalancing/access-logs
# https://docs.aws.amazon.com/elasticloadbalancing/latest/application/load-balancer-access-logs.html
access_log_bucket_name_postfix = "alb-bucket"
access_log_bucket_log_prefix   = "dev"
