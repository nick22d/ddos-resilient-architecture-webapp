# Export the VPC parameter so that it can be populated by the root module
variable "vpc" {
  description = "The main VPC."
}

# Export the 'Security Group for the ALB' parameter so that it can be populated by the root module
variable "sg_for_alb" {
  description = "The SG for ALB."
}

# Export the public subnets so that they can be populated by the root module
variable "public_subnets" {
  description = "The public subnets."
}

# Export the port used for HTTP traffic so that it can be populated by the root module
variable "http_traffic_port" {
  description = "The port used for HTTP traffic."
}