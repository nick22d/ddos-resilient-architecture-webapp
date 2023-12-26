#!/bin/bash

# Uncomment the edge module
sed -i '21,30 s/^##*//' terraform.tf

# Uncomment lines 2-100 from the folder's contents (main.tf, outputs.tf and variables.tf)
sed -i '2,100 s/^##*//' ./modules/edge/* 

# Uncomment the route to the IGW 
sed -i '/#destination_prefix_list_id = var.cloudfront_managed_prefix_list/c\destination_prefix_list_id = var.cloudfront_managed_prefix_list' ./modules/network/main.tf

# Comment out the default route of 0.0.0.0/0
sed -i '/cidr_block = local.default_cidr_block/c\#cidr_block = local.default_cidr_block' ./modules/network/main.tf

# Uncomment the prefix list from the ALB's SG
sed -i '/#prefix_list_ids = \[var.cloudfront_managed_prefix_list\]/c\prefix_list_ids = [var.cloudfront_managed_prefix_list]' ./modules/network/main.tf

# Comment out the 0.0.0.0/0 block from the ALB's SG 
sed -i '76 s/^c/#c/' ./modules/network/main.tf