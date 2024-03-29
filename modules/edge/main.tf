# Define a list of local values for centralised reference
locals {
  origin_protocol_policy = "http-only"

  ssl_protocol = "TLSv1.2"

  geo_restriction_type = "whitelist"

  viewer_protocol_policy = "allow-all"

  blanket_based_rate_limit_rule_threshold = 500
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

    origin_shield {
      enabled = true
      # The London region is specified here because Paris is not a region in which CloudFront offers Origin Shield
      origin_shield_region = "eu-west-2"
    }

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

  web_acl_id = aws_wafv2_web_acl.edge_acl.arn

  viewer_certificate {
    cloudfront_default_certificate = true
  }
}

# Create the WAF ACL that will be attached to the CloudFront distribution
resource "aws_wafv2_web_acl" "edge_acl" {
  description = "This is the WAF web ACL that will be attached to the CloudFront distribution."
  name        = "edge_acl"
  scope       = "CLOUDFRONT"
  provider    = aws.virginia

  visibility_config {
    cloudwatch_metrics_enabled = false
    metric_name                = "edge_acl_monitoring"
    sampled_requests_enabled   = true
  }

  default_action {
    allow {}
  }

  # Create the blanket rate-based rule that will apply to all inbound requests indiscriminately
  rule {
    name     = "blanket_based_rate_limit_rule"
    priority = 1

    action {
      block {}
    }

    statement {
      rate_based_statement {
        limit              = local.blanket_based_rate_limit_rule_threshold
        aggregate_key_type = "IP"
      }
    }

    visibility_config {
      cloudwatch_metrics_enabled = false
      metric_name                = "rate_based_rule_monitoring"
      sampled_requests_enabled   = true
    }
  }

  # Create the 'AWSManagedRulesCommonRuleSet' managed rule 
  rule {
    name     = "AWSManagedRulesCommonRuleSet"
    priority = 2

    override_action {
      none {}
    }

    statement {
      managed_rule_group_statement {
        name        = "AWSManagedRulesCommonRuleSet"
        vendor_name = "AWS"
      }
    }

    visibility_config {
      cloudwatch_metrics_enabled = false
      metric_name                = "AWSManagedRulesCommonRuleSet_monitoring"
      sampled_requests_enabled   = true
    }
  }

  # Create the 'AWSManagedRulesKnownBadInputsRuleSet' managed rule 
  rule {
    name     = "AWSManagedRulesKnownBadInputsRuleSet"
    priority = 3

    override_action {
      none {}
    }

    statement {
      managed_rule_group_statement {
        name        = "AWSManagedRulesKnownBadInputsRuleSet"
        vendor_name = "AWS"
      }
    }

    visibility_config {
      cloudwatch_metrics_enabled = false
      metric_name                = "AWSManagedRulesKnownBadInputsRuleSet_monitoring"
      sampled_requests_enabled   = true
    }
  }

  # Create the 'AWSManagedRulesLinuxRuleSet' managed rule 
  rule {
    name     = "AWSManagedRulesLinuxRuleSet"
    priority = 4

    override_action {
      none {}
    }

    statement {
      managed_rule_group_statement {
        name        = "AWSManagedRulesLinuxRuleSet"
        vendor_name = "AWS"
      }
    }

    visibility_config {
      cloudwatch_metrics_enabled = false
      metric_name                = "AWSManagedRulesLinuxRuleSet_monitoring"
      sampled_requests_enabled   = true
    }
  }

  # Create the 'AWSManagedRulesAmazonIpReputationList' managed rule 
  rule {
    name     = "AWSManagedRulesAmazonIpReputationList"
    priority = 5

    override_action {
      none {}
    }

    statement {
      managed_rule_group_statement {
        name        = "AWSManagedRulesAmazonIpReputationList"
        vendor_name = "AWS"
      }
    }

    visibility_config {
      cloudwatch_metrics_enabled = false
      metric_name                = "AWSManagedRulesAmazonIpReputationList_monitoring"
      sampled_requests_enabled   = true
    }
  }

  # Create the 'AWSManagedRulesAnonymousIpList' managed rule 
  rule {
    name     = "AWSManagedRulesAnonymousIpList"
    priority = 6

    override_action {
      none {}
    }

    statement {
      managed_rule_group_statement {
        name        = "AWSManagedRulesAnonymousIpList"
        vendor_name = "AWS"
      }
    }

    visibility_config {
      cloudwatch_metrics_enabled = false
      metric_name                = "AWSManagedRulesAnonymousIpList_monitoring"
      sampled_requests_enabled   = true
    }
  }
}