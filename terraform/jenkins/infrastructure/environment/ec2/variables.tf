##################################################################################
# VARIABLES
##################################################################################

variable "profile" {}
variable "region" {}
variable "bucket" {}

variable "owner" {}
variable "resource_name_prefix" {}
variable "resource_name_postfix" {}

variable "vpc_name_postfix" {}
variable "public_subnet_name_postfix" {}
variable "private_subnet_name_postfix" {}

variable "ec2_type" {}
variable "ec2_key_pair_name_postfix" {}
variable "ec2_user_data_template_path" {}
variable "ec2_security_group_name_postfix" {}
variable "ec2_ebs_root_type" {}
variable "ec2_ebs_root_size" {}
variable "ec2_ebs_root_tag_name_postfix" {}
variable "ec2_ebs_attached_device_name" {}
variable "ec2_ebs_attached_skip_destroy" {}
variable "ec2_ebs_attached_tag_name_postfix" {}

variable "ec2_filter_owners" { type = "list" }
variable "ec2_filter_names" { type = "list" }

variable "ssm_policy_arn" {}
