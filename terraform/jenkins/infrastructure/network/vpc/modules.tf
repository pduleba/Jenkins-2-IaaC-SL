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

module "igw" {
  source = "../../utils/resource"

  resource_name_prefix  = var.resource_name_prefix
  resource_name_postfix = "igw"

  tag_value_owner = var.owner
}

module "ngw-eip" {
  source = "../../utils/resource"

  resource_name_prefix  = var.resource_name_prefix
  resource_name_postfix = "ngw-eip"

  tag_value_owner = var.owner
}

module "ngw" {
  source = "../../utils/resource"

  resource_name_prefix  = var.resource_name_prefix
  resource_name_postfix = "ngw"

  tag_value_owner = var.owner
}

module "public-rt" {
  source = "../../utils/resource"

  resource_name_prefix  = var.resource_name_prefix
  resource_name_postfix = "public-rt"

  tag_value_owner = var.owner
}

module "private-rt" {
  source = "../../utils/resource"

  resource_name_prefix  = var.resource_name_prefix
  resource_name_postfix = "private-rt"

  tag_value_owner = var.owner
}

module "public-acl" {
  source = "../../utils/resource"

  resource_name_prefix  = var.resource_name_prefix
  resource_name_postfix = "public-acl"

  tag_value_owner = var.owner
}

module "private-acl" {
  source = "../../utils/resource"

  resource_name_prefix  = var.resource_name_prefix
  resource_name_postfix = "private-acl"

  tag_value_owner = var.owner
}

module "alb-sg" {
  source = "../../utils/resource"

  resource_name_prefix  = var.resource_name_prefix
  resource_name_postfix = var.alb_security_group_name_postfix
  description           = "ALB intended security group"

  tag_value_owner = var.owner
}

module "bastion-sg" {
  source = "../../utils/resource"

  resource_name_prefix  = var.resource_name_prefix
  resource_name_postfix = var.bastion_security_group_name_postfix
  description           = "BASTION intended security group"

  tag_value_owner = var.owner
}
module "jenkins-sg" {
  source = "../../utils/resource"

  resource_name_prefix  = var.resource_name_prefix
  resource_name_postfix = var.ec2_security_group_name_postfix
  description           = "JENKINS intended security group"

  tag_value_owner = var.owner
}

module "flowlog-cloudwatch-role-policy" {
  source = "../../utils/resource"

  resource_name_prefix  = var.resource_name_prefix
  resource_name_postfix = "flowlog-cloudwatch-role-policy"

  tag_value_owner = var.owner
}

module "flowlog-cloudwatch-role" {
  source = "../../utils/resource"

  resource_name_prefix  = var.resource_name_prefix
  resource_name_postfix = "flowlog-cloudwatch-role"
  description           = "Role allowing VPC to call CloudWatchFlowLogs service on your behalf."

  tag_value_owner = var.owner
}

module "cloudwatch-log-group" {
  source = "../../utils/resource"

  resource_name_prefix    = "/aws/vpc/flowlogs"
  resource_name_delimiter = "/"
  resource_name_postfix   = var.resource_name_prefix

  tag_value_owner = var.owner

  tag_value_name_delimiter = "-"
  tag_value_name_prefix    = var.resource_name_prefix
  tag_value_name_postfix   = "cloudwatch-log-group"
}