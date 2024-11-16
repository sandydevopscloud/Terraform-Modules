resource "aws_lb" "lb_terra" {
  name                       = var.lb_name
  internal                   = false
  load_balancer_type         = "network"
  subnets                    = var.subnets
  enable_deletion_protection = true

  tags = {
    Environment = var.environment
  }
}

resource "aws_lb_target_group" "lb_terra_targetgroup" {
  name     = var.target_group
  port     = 80
  protocol = "TCP"
  vpc_id   = var.vpc_id
}

resource "aws_lb_target_group_attachment" "lb_terra_target_attachment" {
  count            = var.environment == "PRD" ? 3 : 3
  target_group_arn = aws_lb_target_group.lb_terra_targetgroup.arn
  target_id        = element(var.private_servers, count.index)
  port             = 80
}

