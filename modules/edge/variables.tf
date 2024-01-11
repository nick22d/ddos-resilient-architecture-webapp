# Define a variable for CloudFront's cache policy
variable "CloudFront_cache_policy" {
  description = "This variable stores the CloudFront distribution's cache policy."
  type        = string
  default     = "658327ea-f89d-4fab-a63d-7e88639e58f6"
}

# Define a variable for the supported HTTP methods
variable "http_methods" {
  description = "The HTTP methods supported by the CloudFront distribution."
  type        = list(string)
  default = [
    "GET",
    "HEAD"
  ]
}

# Define a variable for the whitelisted countries
variable "whitelisted_countries" {
  description = "The list of countries that CloudFront will allow to make requests."
  type        = list(string)
  default = [
    "LU",
    "US",
    "FR"
  ]
}

###########################################################################################################
/*The variables below allow the 'edge' module to make reference to arguments inside the 'network' module.*/
###########################################################################################################

# Export a variable for CloudFront's domain_name argument so that it can be populated by the root module
variable "domain_name" {
  description = "Reference to the ALB's DNS name."
  type = string
}

# Export a variable for CloudFront's origin_id argument so that it can be populated by the root module
variable "origin_id" {
  description = "Reference to the ALB's DNS name."
  type = string
}

# Export a variable for CloudFront's target_origin_id argument so that it can be populated by the root module
variable "target_origin_id" {
  description = "Reference to the ALB's DNS name."
  type = string
}

# Export a variable for the HTTP traffic port so that it can be populated by the root module
variable "http_traffic_port" {
  description = "The main traffic port listening on client HTTP traffic."
  type        = number
}

# Export a variable for the HTTPs traffic port so that it can be populated by the root module
variable "https_traffic_port" {
  description = "The main traffic port listening on client HTTPs traffic."
  type        = number
}