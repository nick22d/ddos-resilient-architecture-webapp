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

#############
/* MODULES */
#############

# Call the 'network' module
module "network" {
  source = "./modules/network"
}

# Call the 'edge' module
module "edge" {
  source = "./modules/edge"

  domain_name      = module.network.alb_dns_name
  origin_id        = module.network.alb_dns_name
  target_origin_id = module.network.alb_dns_name

  depends_on = [module.network]
}