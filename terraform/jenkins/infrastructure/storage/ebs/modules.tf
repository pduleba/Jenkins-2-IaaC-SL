##################################################################################
# MODULES
##################################################################################

module "ebs" {
  source = "../../utils/resource"

  resource_name_prefix  = var.resource_name_prefix
  resource_name_postfix = var.ebs_tag_name_postfix

  tag_value_owner = var.owner
}

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
