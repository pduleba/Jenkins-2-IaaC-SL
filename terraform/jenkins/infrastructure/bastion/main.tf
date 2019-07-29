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

variable "ec2_filter_owners" { type = "list" }
variable "ec2_filter_names" { type = "list" }
variable "ec2_filter_root_device_types" { type = "list" }
variable "ec2_filter_virtualization_types" { type = "list" }

variable "ssm_policy_arn" {}

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
  resource_name_postfix = "bastion"

  vpc_name_postfix            = var.vpc_name_postfix
  public_subnet_name_postfix  = var.public_subnet_name_postfix
  private_subnet_name_postfix = var.private_subnet_name_postfix

  ec2_type                        = var.ec2_type
  ec2_key_pair_name_postfix       = var.ec2_key_pair_name_postfix
  ec2_user_data_template_path     = var.ec2_user_data_template_path
  ec2_security_group_name_postfix = var.ec2_security_group_name_postfix
  ec2_ebs_root_type               = var.ec2_ebs_root_type
  ec2_ebs_root_size               = var.ec2_ebs_root_size
  ec2_ebs_root_tag_name_postfix   = var.ec2_ebs_root_tag_name_postfix

  ec2_filter_owners               = var.ec2_filter_owners
  ec2_filter_names                = var.ec2_filter_names
  ec2_filter_root_device_types    = var.ec2_filter_root_device_types
  ec2_filter_virtualization_types = var.ec2_filter_virtualization_types

  ssm_policy_arn = var.ssm_policy_arn
}