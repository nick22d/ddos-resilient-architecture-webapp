# Output the DNS name of the CloudFront distribution
output "cloudfront_domain" {
  description = "Return the DNS name of the CloudFront distribution."
  value       = module.edge.cloudfront_dns_name
}
