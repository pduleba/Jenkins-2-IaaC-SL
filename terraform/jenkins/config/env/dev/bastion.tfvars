##################################################################################
# VARIABLES
##################################################################################

vpc_name_postfix            = "vpc"
public_subnet_name_postfix  = "public-subnet"
private_subnet_name_postfix = "private-subnet"

ec2_type                        = "t2.nano"
ec2_key_pair_name_postfix       = "key-pair"
ec2_user_data_template_path     = "./../../config/templates/bastion_user_data.tpl"
ec2_security_group_name_postfix = "bastion-sg"
ec2_ebs_root_type               = "gp2"
ec2_ebs_root_size               = 50
ec2_ebs_root_tag_name_postfix   = "root-ebs"

ec2_filter_owners               = ["amazon"]
ec2_filter_names                = ["amzn2-ami-hvm-2.0.????????-x86_64-gp2"]
ec2_filter_root_device_types    = ["ebs"]
ec2_filter_virtualization_types = ["hvm"]

ssm_policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2RoleforSSM"
