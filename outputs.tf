# Return the DNS name of the ALB
output "alb_dns_name" {
  description = "The DNS name of the ALB."
  value       = module.frontend-app.alb_dns_name
}

# Return the DNS name of the CloudFront distribution
output "cloudfront_domain" {
  description = "The DNS name of the CloudFront distribution."
  value       = module.edge.cloudfront_dns_name
}