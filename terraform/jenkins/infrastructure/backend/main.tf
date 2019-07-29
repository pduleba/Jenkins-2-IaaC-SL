##################################################################################
# VARIABLES
##################################################################################

variable "profile" {}
variable "region" {}
variable "bucket" {}

variable "owner" {}
variable "resource_name_prefix" {}

##################################################################################
# DATA
##################################################################################

data "aws_caller_identity" "current" {}

# https://www.terraform.io/docs/providers/aws/guides/iam-policy-documents.html
data "aws_iam_policy_document" "backend_policy_document" {
  statement {
    effect = "Allow"

    actions = ["s3:*"]

    resources = [
      "arn:aws:s3:::${var.bucket}/*",
    ]

    // principals - bucket creator access only by default
    principals {
      type        = "AWS"
      identifiers = [data.aws_caller_identity.current.arn]
    }
  }
}

##################################################################################
# MODULES
##################################################################################

module "backend-bucket" {
  source = "../utils/resource"

  // Due to limitation of Terraform init, name of bucket needs to be provided via variable
  resource_name_prefix  = var.resource_name_prefix
  resource_name_postfix = replace(var.bucket, "${var.resource_name_prefix}-", "")

  tag_value_owner = var.owner
}

##################################################################################
# RESOURCES
##################################################################################

resource "aws_s3_bucket" "backend_bucket" {
  bucket = var.bucket

  acl           = "private"
  force_destroy = "true"
  policy        = data.aws_iam_policy_document.backend_policy_document.json

  tags = module.backend-bucket.tags
}

##################################################################################
# OUTPUT
##################################################################################

output "backend_bucket" {
  value = aws_s3_bucket.backend_bucket.bucket
}

