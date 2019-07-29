##################################################################################
# LOCALS
##################################################################################

locals {}

##################################################################################
# RESOURCES
##################################################################################

resource "aws_instance" "ec2" {
  # AMI
  ami = data.aws_ami.image.id

  # Instance type
  instance_type = var.ec2_type

  # Configure instance
  subnet_id                   = data.aws_subnet.public.*.id[0]
  availability_zone           = data.aws_subnet.public.*.availability_zone[0]
  associate_public_ip_address = true
  placement_group             = null // no placement group by default
  credit_specification {
    cpu_credits = "standard"
  }
  iam_instance_profile                 = aws_iam_instance_profile.ec2_instance_profile.name
  instance_initiated_shutdown_behavior = "terminate"
  disable_api_termination              = false
  monitoring                           = false
  tenancy                              = "default"
  source_dest_check                    = true
  user_data                            = data.template_file.user_data.rendered

  # Storage
  root_block_device {
    volume_type           = var.ec2_ebs_root_type
    volume_size           = var.ec2_ebs_root_size
    delete_on_termination = true
  }

  # Security groups
  vpc_security_group_ids = list(data.aws_security_group.ec2.id)

  # Review
  key_name = module.ec2-key-pair.resource-name

  # Tags
  volume_tags = module.ec2-ebs-root.tags
  tags        = module.ec2.tags
}

resource "aws_iam_instance_profile" "ec2_instance_profile" {
  name = module.ec2-instance-profile.resource-name
  role = aws_iam_role.ec2_role.name
}

resource "aws_iam_role" "ec2_role" {
  name = module.ec2-role.resource-name

  description        = module.ec2-role.description
  assume_role_policy = data.aws_iam_policy_document.ec2_assume_role_policy.json

  tags = module.ec2-role.tags
}

resource "aws_iam_role_policy_attachment" "ec2_attach_amazon_ssm_policy" {
  role       = aws_iam_role.ec2_role.id
  policy_arn = data.aws_iam_policy.ssm_policy.arn
}
