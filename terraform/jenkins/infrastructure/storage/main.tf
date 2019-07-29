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

variable "ebs_type" {}
variable "ebs_size" {}
variable "ebs_tag_name_postfix" {}

variable "ec2_key_pair_name_postfix" {}

##################################################################################
# MODULES
##################################################################################

module "ebs" {
  source = "./ebs"

  profile = var.profile
  region  = var.region
  bucket  = var.bucket

  owner                = var.owner
  resource_name_prefix = var.resource_name_prefix

  vpc_name_postfix            = var.vpc_name_postfix
  public_subnet_name_postfix  = var.public_subnet_name_postfix
  private_subnet_name_postfix = var.private_subnet_name_postfix

  ebs_type             = var.ebs_type
  ebs_size             = var.ebs_size
  ebs_tag_name_postfix = var.ebs_tag_name_postfix
}

module "ec2" {
  source = "./ec2"

  profile = var.profile
  region  = var.region
  bucket  = var.bucket

  owner                = var.owner
  resource_name_prefix = var.resource_name_prefix

  ec2_key_pair_name_postfix = var.ec2_key_pair_name_postfix
}
