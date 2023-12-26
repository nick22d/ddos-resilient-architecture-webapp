The root cause has been identified.

The reason behind the 502 errors is the fact that the backend servers are shown as unhealthy (ALB's health check fails). 

working without cloudfront:

# Create the security group for the ALB
resource "aws_security_group" "sg_for_alb" {
  name        = "sg_for_alb"
  description = "Allow HTTP traffic from the internet."
  vpc_id      = aws_vpc.main.id

  ingress {
    description = "HTTP from the world"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = [local.default_cidr_block]
  }

 Create the route table for the public subnets
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id


  # Default route to the IGW
  route {
    cidr_block = local.default_cidr_block
    gateway_id = aws_internet_gateway.igw.id
  }
}

working with cloudfront:

# Create the security group for the ALB
resource "aws_security_group" "sg_for_alb" {
  name        = "sg_for_alb"
  description = "Allow HTTP traffic from the internet."
  vpc_id      = aws_vpc.main.id

  ingress {
    description = "HTTP from the world"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    prefix_list_ids = [var.cloudfront_managed_prefix_list]
  }

# Create the route table for the public subnets
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  }
  # Default route to the IGW
  route {
    destination_prefix_list_id = var.cloudfront_managed_prefix_list
    gateway_id = aws_internet_gateway.igw.id
  }
}

Given its current form, the configuration script first creates the ALB's security group to listen on the CF, which is 'propagated' over the EC2 instances as well. This results in the failure of the ALB's health check which results in all 4 instances being returned as 'unhealthy'. By the time the CF is deployed therefore, the whole path is broken; hence the 502 errors.

The question therefore revolves around this question: how can the workflow be changed in such a way so that the whole setup works?

Note:

- Region doesn't matter (can be paris).
- A third module of 'server' could be created with the ALB's config and the ASG 