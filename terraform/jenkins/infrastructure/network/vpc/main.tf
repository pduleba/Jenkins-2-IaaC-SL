##################################################################################
# LOCALS
##################################################################################

locals {
  PUBLIC_SUBNET_COUNT = var.subnet_count / 2
  AZS_COUNT           = length(data.aws_availability_zones.azs)
}

##################################################################################
# RESOURCES
##################################################################################

resource "aws_vpc" "vpc" {
  cidr_block = var.vpc_cidr

  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = module.vpc.tags
}

resource "aws_subnet" "subnets" {
  # Loop
  count = var.subnet_count

  vpc_id     = aws_vpc.vpc.id
  cidr_block = cidrsubnet(var.vpc_cidr, 4, count.index)
  availability_zone = data.aws_availability_zones.azs.names[
    (count.index < local.PUBLIC_SUBNET_COUNT ? count.index : count.index - local.PUBLIC_SUBNET_COUNT) % local.AZS_COUNT
  ]
  map_public_ip_on_launch = count.index < local.PUBLIC_SUBNET_COUNT

  tags = count.index < local.PUBLIC_SUBNET_COUNT ? module.public-subnet.tags : module.private-subnet.tags
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id

  tags = module.igw.tags
}

resource "aws_eip" "ngw_eip" {
  vpc              = true
  public_ipv4_pool = "amazon"

  tags = module.ngw-eip.tags
}

resource "aws_nat_gateway" "ngw" {
  allocation_id = aws_eip.ngw_eip.id

  # Use first public subnet
  subnet_id = aws_subnet.subnets.*.id[0]

  tags = module.ngw.tags
}

resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = module.public-rt.tags
}

resource "aws_route_table" "private_rt" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.ngw.id
  }

  tags = module.private-rt.tags
}

resource "aws_route_table_association" "rt_associations" {
  # Loop
  count = var.subnet_count

  # route_tables[PUBLIC_SUBNET_COUNT].id = public RT + INTERNET GW
  # route_tables[PRIVATE_SUBNET_COUNT].id = private RT + NAT GW
  route_table_id = count.index < local.PUBLIC_SUBNET_COUNT ? aws_route_table.public_rt.id : aws_route_table.private_rt.id

  subnet_id = aws_subnet.subnets.*.id[count.index]
}

resource "aws_network_acl" "nacls" {
  # Loop
  count = 2

  vpc_id = aws_vpc.vpc.id

  subnet_ids = slice(
    aws_subnet.subnets.*.id,
    count.index % 2 < 1 ? 0 : local.PUBLIC_SUBNET_COUNT,
    count.index % 2 < 1 ? local.PUBLIC_SUBNET_COUNT : var.subnet_count
  )


  ingress {
    protocol   = "-1"
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }

  egress {
    protocol   = "-1"
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }

  tags = count.index % 2 < 1 ? module.public-acl.tags : module.private-acl.tags
}

resource "aws_security_group" "bastion_sg" {
  name        = module.bastion-sg.resource-name
  vpc_id      = aws_vpc.vpc.id
  description = module.bastion-sg.description

  ingress {
    protocol    = "tcp"
    from_port   = 22
    to_port     = 22
    cidr_blocks = var.ingress_cidrs
  }

  egress {
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = module.bastion-sg.tags
}

resource "aws_security_group" "alb_sg" {
  name        = module.alb-sg.resource-name
  vpc_id      = aws_vpc.vpc.id
  description = module.alb-sg.description

  ingress {
    protocol    = "tcp"
    from_port   = 8080
    to_port     = 8080
    cidr_blocks = var.ingress_cidrs
  }

  ingress {
    protocol    = "tcp"
    from_port   = 443
    to_port     = 443
    cidr_blocks = var.ingress_cidrs
  }

  ingress {
    protocol    = "tcp"
    from_port   = 50000
    to_port     = 50000
    cidr_blocks = var.ingress_cidrs
  }

  egress {
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = module.alb-sg.tags
}

resource "aws_security_group" "jenkins_sg" {
  name        = module.jenkins-sg.resource-name
  vpc_id      = aws_vpc.vpc.id
  description = module.jenkins-sg.description


  ingress {
    protocol        = "tcp"
    from_port       = 22
    to_port         = 22
    security_groups = list(aws_security_group.bastion_sg.id)
  }

  ingress {
    protocol        = "tcp"
    from_port       = 8080
    to_port         = 8080
    security_groups = list(aws_security_group.alb_sg.id)
  }

  ingress {
    protocol        = "tcp"
    from_port       = 443
    to_port         = 443
    security_groups = list(aws_security_group.alb_sg.id)
  }

  ingress {
    protocol        = "tcp"
    from_port       = 50000
    to_port         = 50000
    security_groups = list(aws_security_group.alb_sg.id)
  }

  egress {
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = module.jenkins-sg.tags
}

resource "aws_iam_role_policy" "flowlog_cloudwatch_role_policy" {
  name = module.flowlog-cloudwatch-role-policy.resource-name

  role   = aws_iam_role.flowlog_cloudwatch_role.id
  policy = data.aws_iam_policy_document.flowlog_policy.json
}

resource "aws_iam_role" "flowlog_cloudwatch_role" {
  name = module.flowlog-cloudwatch-role.resource-name

  description        = module.flowlog-cloudwatch-role.description
  assume_role_policy = data.aws_iam_policy_document.flowlog_assume_role_policy_document.json

  tags = module.flowlog-cloudwatch-role.tags
}

resource "aws_cloudwatch_log_group" "cloudwatch_log_group" {
  name = module.cloudwatch-log-group.resource-name

  tags = module.cloudwatch-log-group.tags
}

resource "aws_flow_log" "cloudwatch_flowlog" {
  vpc_id = aws_vpc.vpc.id

  traffic_type         = "ALL"
  log_destination_type = "cloud-watch-logs"
  log_destination      = aws_cloudwatch_log_group.cloudwatch_log_group.arn
  iam_role_arn         = aws_iam_role.flowlog_cloudwatch_role.arn
}