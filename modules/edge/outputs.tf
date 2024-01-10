# Export the DNS name of the CloudFront distribution so that it can be output in the root module
output "cloudfront_dns_name" {
  description = "Return the DNS name of the CloudFront distribution."
  value       = aws_cloudfront_distribution.distribution.domain_name
}