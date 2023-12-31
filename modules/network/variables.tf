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

# Export a variable for the HTTP traffic port so that it can be populated by the root module
variable "http_traffic_port" {
  description = "The main traffic port listening on client HTTP traffic."
  type        = number
}

# Define a variable for the ALB's health check port
variable "health_check_port" {
  description = "The port of the backend servers the ALB communicates to for its health checks."
  type        = number
  default     = 8080
}

# Define a variable for the transport protocol
variable "transport_protocol" {
  description = "The main transport protocol in use for the client traffic."
  type        = string
  default     = "tcp"
}

# Define a variable for the application layer protocol
variable "application_protocol" {
  description = "The application layer protocol in use for the client traffic."
  type        = string
  default     = "HTTP"
}

# Define a variable for the EC2 instance type
variable "instance_type" {
  description = "The EC2 instance type used for the backend servers."
  type        = string
  default     = "t2.micro"
}

# Define a variable for CloudFront's managed prefix list
variable "cloudfront_managed_prefix_list" {
  description = "CloudFront's managed prefix list."
  type        = string
  default     = "pl-75b1541c"
}
