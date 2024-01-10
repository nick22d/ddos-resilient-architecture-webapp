# Define a list of local values for centralised reference
locals {
  origin_protocol_policy = "http-only"

  ssl_protocol = "TLSv1.2"

  geo_restriction_type = "whitelist"

  viewer_protocol_policy = "allow-all"
}

# Define a provider for the us-east-1 region
provider "aws" {
  alias  = "virginia"
  region = "us-east-1"
}

# Create the CloudFront distribution
resource "aws_cloudfront_distribution" "distribution" {
  origin {
    domain_name = var.domain_name
    origin_id   = var.origin_id

    custom_origin_config {
      http_port              = var.http_traffic_port
      https_port             = var.https_traffic_port
      origin_protocol_policy = local.origin_protocol_policy
      origin_ssl_protocols   = [local.ssl_protocol]
    }
  }

  enabled         = true
  is_ipv6_enabled = false

  default_cache_behavior {
    allowed_methods  = var.http_methods
    cached_methods   = var.http_methods
    target_origin_id = var.target_origin_id


    cache_policy_id = var.CloudFront_cache_policy

    compress = true

    viewer_protocol_policy = local.viewer_protocol_policy

  }

  restrictions {
    geo_restriction {
      restriction_type = local.geo_restriction_type
      locations        = var.whitelisted_countries
    }
  }

  #web_acl_id = aws_wafv2_web_acl.edge_acl.arn

  tags = {
    Name = "ManagedByTF"
  }

  viewer_certificate {
    cloudfront_default_certificate = true
  }
}

# # Create the WAF ACL that will be attached to the CloudFront distribution
# resource "aws_wafv2_web_acl" "edge_acl" {
#   description = "This is the WAF web ACL that will be attached to the CloudFront distribution."
#   name = "edge_acl"
#   scope = "CLOUDFRONT"

#   visibility_config {
#     cloudwatch_metrics_enabled = false
#     metric_name                = "edge_acl_monitoring"
#     sampled_requests_enabled   = true
#   }

#   default_action {
#     allow {}
#   }  
# }