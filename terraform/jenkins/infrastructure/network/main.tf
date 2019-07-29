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

variable "alb_security_group_name_postfix" {}
variable "bastion_security_group_name_postfix" {}
variable "ec2_security_group_name_postfix" {}

variable "vpc_cidr" {}
variable "subnet_count" {}
variable "subnet_mask_newbits" {}
variable "ingress_cidrs" {}

##################################################################################
# MODULES
##################################################################################

module "vpc" {
  source = "./vpc"

  profile = var.profile
  region  = var.region
  bucket  = var.bucket

  owner                = var.owner
  resource_name_prefix = var.resource_name_prefix

  vpc_name_postfix            = var.vpc_name_postfix
  public_subnet_name_postfix  = var.public_subnet_name_postfix
  private_subnet_name_postfix = var.private_subnet_name_postfix

  alb_security_group_name_postfix     = var.alb_security_group_name_postfix
  bastion_security_group_name_postfix = var.bastion_security_group_name_postfix
  ec2_security_group_name_postfix     = var.ec2_security_group_name_postfix

  vpc_cidr            = var.vpc_cidr
  subnet_count        = var.subnet_count
  subnet_mask_newbits = var.subnet_mask_newbits
  ingress_cidrs       = var.ingress_cidrs
}
