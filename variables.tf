# Define a variable for the port used for HTTP traffic
variable "http_traffic_port" {
  description = "The port used for HTTP traffic."
  type = number
  default     = 80
}

# Define a variable for the port used for HTTPs traffic
variable "https_traffic_port" {
  description = "The port used for HTTPs traffic."
  type = number
  default = 443  
}