/*
Project: A DDoS-resilient architecture for web applications
Author: Nikolaos Doropoulos
*/

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

# Call the 'network' module
module "network" {
  source = "./modules/network"
}

# Call the 'backend-app' module
module "backend-app" {
  source = "./modules/backend-app"

  vpc = module.network.vpc

  sg_for_alb = module.backend-app.sg_for_alb

  sg_for_ec2 = module.backend-app.sg_for_ec2

  public_subnets = module.network.public_subnets

  private_subnets = module.network.private_subnets

  aws_lb_target_group = module.frontend-app.alb_target_group
}

# Call the 'frontend-app' module
module "frontend-app" {
  source = "./modules/frontend-app"

  vpc = module.network.vpc

  sg_for_alb = module.backend-app.sg_for_alb

  public_subnets = module.network.public_subnets
}

# Call the 'edge' module
module "edge" {
  source = "./modules/edge"

  domain_name      = module.frontend-app.alb_dns_name
  origin_id        = module.frontend-app.alb_dns_name
  target_origin_id = module.frontend-app.alb_dns_name

  http_traffic_port = 80

  https_traffic_port = 443
}