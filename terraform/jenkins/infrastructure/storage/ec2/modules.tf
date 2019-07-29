##################################################################################
# MODULES
##################################################################################

module "ec2-key-pair" {
  source = "../../utils/resource"

  resource_name_prefix  = var.resource_name_prefix
  resource_name_postfix = var.ec2_key_pair_name_postfix

  tag_value_owner = var.owner
}
