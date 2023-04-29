# This creates alb
resource "aws_lb" "alb" {
  name               = var.ALB_NAME
  internal           = var.INTERNAL
  load_balancer_type = "application"
  security_groups    = local.SG
  subnets            = local.SUBNET_IDS
  tags = {
    Name             = var.ALB_NAME
  }
}