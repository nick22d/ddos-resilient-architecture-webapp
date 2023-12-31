# Define a variable for the HTTP traffic port
variable "http_traffic_port" {
  description = "The main traffic port listening on client HTTP traffic."
  type        = number
  default     = 80
}

# Define a variable for the HTTPs traffic port
variable "https_traffic_port" {
  description = "The main traffic port listening on client HTTPs traffic."
  type        = number
  default     = 443
}