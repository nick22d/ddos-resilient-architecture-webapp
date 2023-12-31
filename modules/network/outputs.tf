# Export the DNS name of the ALB so that it can be output in the root module
output "alb_dns_name" {
  value = aws_lb.alb.dns_name
}