##################################################################################
# DATA
##################################################################################

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

data "aws_security_group" "ec2" {
  tags = module.ec2-security-group.tags
}

data "aws_ebs_volume" "attched-ebs" {
  most_recent = true

  filter {
    name = "tag:${module.ec2-ebs-attached.tag-key-name}"
    values = [
      lookup(
        module.ec2-ebs-attached.tags,
        module.ec2-ebs-attached.tag-key-name
      )
    ]
  }
}

data "aws_iam_policy" "ssm_policy" {
  arn = var.ssm_policy_arn
}

data "template_file" "user_data" {
  template = file(var.ec2_user_data_template_path)
  vars = {
    EBS_DEVICE = var.ec2_ebs_attached_device_name
  }
}

data "aws_ami" "image" {
  most_recent = true
  owners      = var.ec2_filter_owners

  filter {
    name   = "name"
    values = var.ec2_filter_names
  }
}

data "aws_iam_policy_document" "ec2_assume_role_policy" {
  statement {

    effect = "Allow"

    actions = [
      "sts:AssumeRole",
    ]

    principals {
      type = "Service"

      identifiers = [
        "ec2.amazonaws.com",
      ]
    }
  }
}
