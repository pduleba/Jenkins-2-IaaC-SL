##################################################################################
# VARIABLES
##################################################################################

variable "resource_name_prefix" {}
variable "resource_name_delimiter" { default = "-" }
variable "resource_name_postfix" {}

variable "tag_key_owner" { default = "Owner" }
variable "tag_value_owner" {}

variable "tag_key_name" { default = "Name" }
variable "tag_value_name_prefix" { default = "" }
variable "tag_value_name_delimiter" { default = "" }
variable "tag_value_name_postfix" { default = "" }

variable "description" { default = "" }

variable "path" { default = "" }

##################################################################################
# LOCALS
##################################################################################

locals {
  RESOURCE_NAME = format(
    "%s%s%s",
    var.resource_name_prefix,
    var.resource_name_delimiter,
    var.resource_name_postfix
  )
  BASE_TAGS = map(
    var.tag_key_owner,
    var.tag_value_owner
  )
  TAGS = merge(
    local.BASE_TAGS,
    map(
      var.tag_key_name,
      format(
        "%s%s%s",
        coalesce(var.tag_value_name_prefix, var.resource_name_prefix),
        coalesce(var.tag_value_name_delimiter, var.resource_name_delimiter),
        coalesce(var.tag_value_name_postfix, var.resource_name_postfix)
      )
    )
  )
}

##################################################################################
# OUTPUTS
##################################################################################

output "resource-name" {
  value = local.RESOURCE_NAME
}

output "tag-key-owner" {
  value = var.tag_key_owner
}

output "tag-key-name" {
  value = var.tag_key_name
}

output "description" {
  value = var.description
}

output "path" {
  value = var.path
}

output "base_tags" {
  value = local.BASE_TAGS
}

output "tags" {
  value = local.TAGS
}
