# Define a list of local values for centralised reference
locals {
  origin_protocol_policy = "http-only"

  ssl_protocol = "TLSv1.2"

  geo_restriction_type = "whitelist"

  viewer_protocol_policy = "allow-all"
}

# Create the CloudFront distribution
resource "aws_cloudfront_distribution" "distribution" {
  origin {
    domain_name = var.domain_name
    origin_id   = var.origin_id

    custom_origin_config {
      http_port              = var.http_traffic_port
      https_port             = 443
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

  tags = {
    Name = "ManagedByTF"
  }

  viewer_certificate {
    cloudfront_default_certificate = true
  }
}