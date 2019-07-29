##################################################################################
# LOCALS
##################################################################################

locals {}

##################################################################################
# RESOURCES
##################################################################################

resource "aws_alb" "alb" {
  # must contain only alphanumeric characters or hyphens, and must not begin or end with a hyphen.
  name = module.alb.resource-name

  # Basic Configuration
  load_balancer_type = "application"
  internal           = false
  ip_address_type    = "ipv4"

  subnets = data.aws_subnet.public.*.id

  # Security groups
  security_groups = list(data.aws_security_group.alb.id)

  # Attributes
  enable_deletion_protection = false
  idle_timeout               = 60
  enable_http2               = true
  access_logs {
    enabled = true
    bucket  = module.access-log-bucket.resource-name
    prefix  = var.access_log_bucket_log_prefix
  }

  # Listeners

  tags = module.alb.tags
}

resource "aws_alb_listener" "alb_listener" {
  load_balancer_arn = aws_alb.alb.arn
  port              = var.alb_port
  protocol          = var.alb_protocol

  default_action {
    type = "redirect"
    redirect {
      port     = var.alb_port
      protocol = var.alb_protocol

      host  = "#{host}"
      path  = var.alb_listener_default_action_redirect_path
      query = "#{query}"

      status_code = "HTTP_301"
    }
  }
}

resource "aws_alb_listener_rule" "alb_listener_rule" {

  listener_arn = aws_alb_listener.alb_listener.arn
  priority     = 1 // between 1 - 50000

  condition {
    field  = "path-pattern"
    values = var.alb_listener_rule_condition_values
  }

  action {
    type             = "forward"
    target_group_arn = aws_alb_target_group.target_group.arn
  }
}

resource "aws_alb_target_group" "target_group" {

  # must contain only alphanumeric characters or hyphens, and must not begin or end with a hyphen.
  name = module.target-group.resource-name

  # Configuration
  target_type = "instance"
  protocol    = var.alb_protocol
  port        = var.alb_port
  vpc_id      = data.aws_vpc.vpc.id

  # Delays
  deregistration_delay = var.target_group_deregistration_delay
  slow_start           = var.target_group_slow_start

  # Health check settings
  health_check {
    protocol = var.alb_protocol
    path     = module.target-group.path

    # Advanced health check settings
    port                = "traffic-port"
    healthy_threshold   = 5
    unhealthy_threshold = 2
    timeout             = 5
    interval            = 10
    matcher             = "200"
  }

  tags = module.target-group.tags
}

resource "aws_alb_target_group_attachment" "attachments" {
  target_group_arn = aws_alb_target_group.target_group.arn
  target_id        = var.target_group_ec2_instance_id
  port             = var.alb_port
}

resource "aws_s3_bucket" "access_log_bucket" {
  bucket = module.access-log-bucket.resource-name

  acl           = "private"
  force_destroy = "true"
  policy        = data.aws_iam_policy_document.access_log_s3_bucket_policy_document.json

  tags = module.access-log-bucket.tags
}