# Output the DNS name of the CloudFront distribution
output "cloudfront_dns_name" {
  description = "Return the DNS name of the CloudFront distribution."
  value       = module.edge.aws_cloudfront_distribution.distribution.domain_name
}
