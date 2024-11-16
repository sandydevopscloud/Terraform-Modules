resource "aws_lb_listener" "lb_front_listener" {
  load_balancer_arn = aws_lb.lb_terra.arn
  port              = "80"
  protocol          = "TCP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.lb_terra_targetgroup.arn
  }
}

