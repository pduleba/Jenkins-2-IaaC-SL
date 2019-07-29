##################################################################################
# VARIABLES
##################################################################################

variable "profile" {}
variable "region" {}
variable "bucket" {}

variable "owner" {}
variable "resource_name_prefix" {}
variable "resource_name_postfix" {}

variable "vpc_name_postfix" {}
variable "public_subnet_name_postfix" {}
variable "private_subnet_name_postfix" {}

variable "alb_protocol" {}
variable "alb_port" {}
variable "alb_security_group_name_postfix" {}
variable "alb_listener_default_action_redirect_path" {}
variable "alb_listener_rule_condition_values" { type = "list" }

variable "target_group_path" {}
variable "target_group_slow_start" {}
variable "target_group_deregistration_delay" {}
variable "target_group_ec2_instance_id" {}

variable "access_log_bucket_name_postfix" {}
variable "access_log_bucket_log_prefix" {}
