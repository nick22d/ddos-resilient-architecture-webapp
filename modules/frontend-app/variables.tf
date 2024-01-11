# Export the VPC parameter so that it can be populated by the root module
variable "vpc" {
  description = "The main VPC."
  type        = string
}

# Export the 'Security Group for the ALB' parameter so that it can be populated by the root module
variable "sg_for_alb" {
  description = "The SG for ALB."
  type        = string
}

# Export the public subnets so that they can be populated by the root module
variable "public_subnets" {
  description = "The public subnets."
  type        = any
}

# Export the port used for HTTP traffic so that it can be populated by the root module
variable "http_traffic_port" {
  description = "The port used for HTTP traffic."
  type        = number
}