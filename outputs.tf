# Output the DNS name of the CloudFront distribution
output "cloudfront_domain" {
  description = "Return the DNS name of the CloudFront distribution."
  value       = module.edge.cloudfront_dns_name
}

# Output the DNS name of the ALB
output "alb_dns_name" {
  description = "Return the DNS name of the ALB."
  value       = module.network.alb_dns_name
}