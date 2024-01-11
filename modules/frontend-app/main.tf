# Define a list of local values for centralised reference
locals {
  application_layer_protocol = "HTTP"

  http_health_check_port = 8080
}

# Create the ALB
resource "aws_lb" "alb" {
  name               = "alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.sg_for_alb]
  subnets            = [for subnet in var.public_subnets : subnet.id]

  enable_deletion_protection = false
}

# Create the target group for the ALB
resource "aws_lb_target_group" "lb_tg" {
  name     = "tg"
  port     = var.http_traffic_port
  protocol = local.application_layer_protocol
  vpc_id   = var.vpc

  health_check {
    path                = "/"
    protocol            = local.application_layer_protocol
    port                = local.http_health_check_port
    matcher             = "200"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 5
  }
}

# Create a listener for the ALB
resource "aws_lb_listener" "listener" {
  load_balancer_arn = aws_lb.alb.arn
  port              = var.http_traffic_port
  protocol          = local.application_layer_protocol

  default_action {
    type = "fixed-response"

    fixed_response {
      content_type = "text/plain"
      message_body = "404: page not found"
      status_code  = 404
    }
  }
}

# Create a listener rule for the ALB
resource "aws_lb_listener_rule" "lb_rule" {
  listener_arn = aws_lb_listener.listener.arn
  priority     = 100

  condition {
    path_pattern {
      values = ["*"]
    }
  }

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.lb_tg.arn
  }
}