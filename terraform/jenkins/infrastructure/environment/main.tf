##################################################################################
# VARIABLES
##################################################################################

variable "profile" {}
variable "region" {}
variable "bucket" {}

variable "owner" {}
variable "resource_name_prefix" {}

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

variable "alb_protocol" {}
variable "alb_port" {}
variable "alb_security_group_name_postfix" {}
variable "alb_listener_default_action_redirect_path" {}
variable "alb_listener_rule_condition_values" { type = "list" }

variable "target_group_path" {}
variable "target_group_slow_start" {}
variable "target_group_deregistration_delay" {}

variable "access_log_bucket_name_postfix" {}
variable "access_log_bucket_log_prefix" {}

##################################################################################
# MODULES
##################################################################################

module "ec2" {
  source = "./ec2"

  profile = var.profile
  region  = var.region
  bucket  = var.bucket

  owner                 = var.owner
  resource_name_prefix  = var.resource_name_prefix
  resource_name_postfix = "server"

  vpc_name_postfix            = var.vpc_name_postfix
  public_subnet_name_postfix  = var.public_subnet_name_postfix
  private_subnet_name_postfix = var.private_subnet_name_postfix

  ec2_type                          = var.ec2_type
  ec2_key_pair_name_postfix         = var.ec2_key_pair_name_postfix
  ec2_user_data_template_path       = var.ec2_user_data_template_path
  ec2_security_group_name_postfix   = var.ec2_security_group_name_postfix
  ec2_ebs_root_type                 = var.ec2_ebs_root_type
  ec2_ebs_root_size                 = var.ec2_ebs_root_size
  ec2_ebs_root_tag_name_postfix     = var.ec2_ebs_root_tag_name_postfix
  ec2_ebs_attached_device_name      = var.ec2_ebs_attached_device_name
  ec2_ebs_attached_skip_destroy     = var.ec2_ebs_attached_skip_destroy
  ec2_ebs_attached_tag_name_postfix = var.ec2_ebs_attached_tag_name_postfix

  ec2_filter_owners = var.ec2_filter_owners
  ec2_filter_names  = var.ec2_filter_names

  ssm_policy_arn = var.ssm_policy_arn
}

module "alb" {
  source = "./alb"

  profile = var.profile
  region  = var.region
  bucket  = var.bucket

  owner                 = var.owner
  resource_name_prefix  = var.resource_name_prefix
  resource_name_postfix = "alb"

  vpc_name_postfix            = var.vpc_name_postfix
  public_subnet_name_postfix  = var.public_subnet_name_postfix
  private_subnet_name_postfix = var.private_subnet_name_postfix

  alb_protocol                              = var.alb_protocol
  alb_port                                  = var.alb_port
  alb_security_group_name_postfix           = var.alb_security_group_name_postfix
  alb_listener_default_action_redirect_path = var.alb_listener_default_action_redirect_path
  alb_listener_rule_condition_values        = var.alb_listener_rule_condition_values

  target_group_path                 = var.target_group_path
  target_group_slow_start           = var.target_group_slow_start
  target_group_deregistration_delay = var.target_group_deregistration_delay
  target_group_ec2_instance_id      = module.ec2.ec2_id

  access_log_bucket_name_postfix = var.access_log_bucket_name_postfix
  access_log_bucket_log_prefix   = var.access_log_bucket_log_prefix
}