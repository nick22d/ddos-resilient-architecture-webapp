# Define a variable for the HTTP traffic port
variable "http_traffic_port" {
  description = "The main traffic port listening on client HTTP traffic."
  type        = number
  default     = 80
}