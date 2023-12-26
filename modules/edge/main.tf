# # # Create the CloudFront distribution
#   resource "aws_cloudfront_distribution" "distribution" {
#     origin {
#       domain_name = var.domain_name
#       origin_id   = var.origin_id

#       custom_origin_config {
#         http_port              = 80
#         https_port             = 443
#         origin_protocol_policy = "http-only"
#         origin_ssl_protocols   = ["TLSv1.2"]
#       }
#     }

#     enabled         = true
#     is_ipv6_enabled = false

#     default_cache_behavior {
#       allowed_methods  = ["GET", "HEAD"]
#       cached_methods   = ["GET", "HEAD"]
#       target_origin_id = var.target_origin_id


#       cache_policy_id = var.CloudFront_cache_policy

#       compress = true

#       viewer_protocol_policy = "allow-all"

#     }

#     restrictions {
#       geo_restriction {
#         restriction_type = "none"
#         locations        = []
#       }
#     }

#     tags = {
#       Name = "ManagedByTF"
#     }

#     viewer_certificate {
#       cloudfront_default_certificate = true
#     }
#   }