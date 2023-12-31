# Define the main terraform block
terraform {
  required_version = ">=1.6.6"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "eu-west-3"
}

#############
/* MODULES */
#############

# Call the 'network' module
module "network" {
  source = "./modules/network"

  # Reference to the HTTP port 80 defined in a variable inside the root module
  http_traffic_port = var.http_traffic_port
}

# Call the 'edge' module
module "edge" {
  source = "./modules/edge"

  # Reference to the HTTP port 80 defined in a variable inside the root module
  http_traffic_port = var.http_traffic_port

  # Enable CloudFront to reference ALB's DNS name from the 'network' module
  domain_name      = module.network.alb_dns_name
  origin_id        = module.network.alb_dns_name
  target_origin_id = module.network.alb_dns_name

  # Ensure that the 'edge' module gets deployed after the 'network' module
  depends_on = [module.network]
}