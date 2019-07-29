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

module "alb-sg" {
  source = "../../utils/resource"

  resource_name_prefix  = var.resource_name_prefix
  resource_name_postfix = var.alb_security_group_name_postfix

  tag_value_owner = var.owner
}

module "alb" {
  source = "../../utils/resource"

  resource_name_prefix  = var.resource_name_prefix
  resource_name_postfix = "alb"

  tag_value_owner = var.owner
}

module "target-group" {
  source = "../../utils/resource"

  resource_name_prefix  = var.resource_name_prefix
  resource_name_postfix = "tg"

  path = var.target_group_path

  tag_value_owner = var.owner
}

module "access-log-bucket" {
  source = "../../utils/resource"

  resource_name_prefix  = var.resource_name_prefix
  resource_name_postfix = var.access_log_bucket_name_postfix

  tag_value_owner = var.owner
}
