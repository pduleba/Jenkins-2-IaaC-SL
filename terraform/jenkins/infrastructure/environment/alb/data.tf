##################################################################################
# DATA
##################################################################################

data "aws_caller_identity" "current" {}

data "aws_elb_service_account" "main" {}

data "aws_vpc" "vpc" {
  tags = module.vpc.tags
}

data "aws_subnet_ids" "public" {
  vpc_id = data.aws_vpc.vpc.id
  tags   = module.public-subnet.tags
}

data "aws_subnet_ids" "private" {
  vpc_id = data.aws_vpc.vpc.id
  tags   = module.private-subnet.tags
}

data "aws_subnet" "public" {
  id    = tolist(data.aws_subnet_ids.public.ids)[count.index]
  count = length(data.aws_subnet_ids.public.ids)
}

data "aws_subnet" "private" {
  id    = tolist(data.aws_subnet_ids.private.ids)[count.index]
  count = length(data.aws_subnet_ids.private.ids)
}

data "aws_security_group" "alb" {
  tags = module.alb-sg.tags
}

data "aws_iam_policy_document" "access_log_s3_bucket_policy_document" {
  # https://docs.aws.amazon.com/elasticloadbalancing/latest/application/load-balancer-access-logs.html
  statement {

    effect = "Allow"

    actions = [
      "s3:PutObject"
    ]

    resources = [
      "arn:aws:s3:::${module.access-log-bucket.resource-name}/${var.access_log_bucket_log_prefix}/AWSLogs/${data.aws_caller_identity.current.account_id}/*"
    ]

    principals {
      type = "AWS"
      identifiers = [
        "arn:aws:iam::${data.aws_elb_service_account.main.id}:root"
      ]
    }
  }
}
