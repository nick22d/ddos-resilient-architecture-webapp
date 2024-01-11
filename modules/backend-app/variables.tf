# Export the VPC parameter so that it can be populated by the root module
variable "vpc" {
  description = "The main VPC."
  type        = string
}

# Export the 'Security Group for EC2' parameter so that it can be populated by the root module
variable "sg_for_ec2" {
  description = "The SG for EC2."
  type        = string
}

# Export the 'Security Group for ALB' parameter so that it can be populated by the root module
variable "sg_for_alb" {
  description = "The SG for ALB."
  type        = string
}

# Export the private subnets so that they can be populated by the root module
variable "private_subnets" {
  description = "The private subnets."
  type        = any
}

# Export the public subnets so that they can be populated by the root module
variable "public_subnets" {
  description = "The public subnets."
  type        = any
}

# Export the ALB's target group so that it can be populated by the root module
variable "aws_lb_target_group" {
  description = "The ALB target group."
  type        = string
}

# Export the HTTP traffic port variable so that it can be populated by the root module
variable "http_traffic_port" {
  description = "The port used for HTTP traffic."
  type        = number
}