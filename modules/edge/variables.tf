# Define a variable for CloudFront's cache policy
variable "CloudFront_cache_policy" {
  description = "This variable stores the CloudFront distribution's cache policy."
  type        = string
  default     = "658327ea-f89d-4fab-a63d-7e88639e58f6"
}

/*The variables below allow the edge module to make reference to arguments inside the network module.*/

# Export a variable for CloudFront's domain_name argument so that it can be populated by the root module
variable "domain_name" {
  description = "Reference to the ALB's DNS name."
}

# Export a variable for CloudFront's origin_id argument so that it can be populated by the root module
variable "origin_id" {
  description = "Reference to the ALB's DNS name."
}

# Export a variable for CloudFront's target_origin_id argument so that it can be populated by the root module
variable "target_origin_id" {
  description = "Reference to the ALB's DNS name."
}