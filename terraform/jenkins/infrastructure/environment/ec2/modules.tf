##################################################################################
# MODULES
##################################################################################

module "vpc" {
  source = "../../utils/resource"

  resource_name_prefix  = var.resource_name_prefix
  resource_name_postfix = var.vpc_name_postfix

  tag_value_owner = var.owner
}

module "public-subnet" {
  source = "../../utils/resource"

  resource_name_prefix  = var.resource_name_prefix
  resource_name_postfix = var.public_subnet_name_postfix

  tag_value_owner = var.owner
}

module "private-subnet" {
  source = "../../utils/resource"

  resource_name_prefix  = var.resource_name_prefix
  resource_name_postfix = var.private_subnet_name_postfix

  tag_value_owner = var.owner
}

module "ec2-security-group" {
  source = "../../utils/resource"

  resource_name_prefix  = var.resource_name_prefix
  resource_name_postfix = var.ec2_security_group_name_postfix

  tag_value_owner = var.owner
}

module "ec2" {
  source = "../../utils/resource"

  resource_name_prefix  = var.resource_name_prefix
  resource_name_postfix = var.resource_name_postfix

  tag_value_owner = var.owner
}

module "ec2-ebs-root" {
  source = "../../utils/resource"

  resource_name_prefix  = var.resource_name_prefix
  resource_name_postfix = var.ec2_ebs_root_tag_name_postfix

  tag_value_owner = var.owner
}

module "ec2-ebs-attached" {
  source = "../../utils/resource"

  resource_name_prefix  = var.resource_name_prefix
  resource_name_postfix = var.ec2_ebs_attached_tag_name_postfix

  tag_value_owner = var.owner
}

module "ec2-key-pair" {
  source = "../../utils/resource"

  resource_name_prefix  = var.resource_name_prefix
  resource_name_postfix = var.ec2_key_pair_name_postfix

  tag_value_owner = var.owner
}

module "ec2-instance-profile" {
  source = "../../utils/resource"

  resource_name_prefix  = var.resource_name_prefix
  resource_name_postfix = "${var.resource_name_postfix}-ec2-instance-profile"

  tag_value_owner = var.owner
}

module "ec2-role" {
  source = "../../utils/resource"

  resource_name_prefix  = var.resource_name_prefix
  resource_name_postfix = "${var.resource_name_postfix}-role"
  description           = "Role allowing EC2 to access infrastructure private resources on your behalf."

  tag_value_owner = var.owner
}
