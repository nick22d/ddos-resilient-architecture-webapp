# Define a variable for storing the CIDR blocks of the public subnets for easy iteration 
variable "public_subnet_cidrs" {
  description = "Public Subnet CIDR blocks."
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

# Define a variable for storing the CIDR blocks of the private subnets for easy iteration
variable "private_subnet_cidrs" {
  description = "Private Subnet CIDR blocks."
  type        = list(string)
  default     = ["10.0.3.0/24", "10.0.4.0/24"]
}

# Define a list of AZs
variable "azs" {
  description = "Availability zones."
  type        = list(string)
  default = [
    "eu-west-3a",
    "eu-west-3b"
  ]
}

# Define a variable for the ALB's health check port
variable "health_check_port" {
  description = "The port of the backend servers the ALB communicates to for its health checks."  
  type = number
  default = 8080
}

# Define a variable for CloudFront's managed prefix list
variable "cloudfront_managed_prefix_list" {
  description = "CloudFront's managed prefix list."
  type        = string
  default     = "pl-75b1541c"
}
