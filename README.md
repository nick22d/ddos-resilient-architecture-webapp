# A DDoS-resilient architecture for web applications

The purpose of this project is to deploy a robust, two-tier architecture in the AWS cloud capable of withstanding DDoS attacks at Layers 3,4 and 7 of the OSI model. The solution has been designed with the [AWS Best Practices for DDoS Resiliency](https://docs.aws.amazon.com/whitepapers/latest/aws-best-practices-ddos-resiliency/aws-best-practices-ddos-resiliency.html) in mind.

The components involved are the following:

* VPC
* EC2
* Auto-scaling group (ASG)
* Application load balancer (ALB)
* Security groups
* CloudFront
* Web application firewall (WAF)
* Shield Standard

## Architectural diagram
![Diagram](images/diagram.png)

## Traffic flow

**1)** HTTP traffic is transmitted from the client to the CloudFront distribution which is the first point of entry into the infrastructure.

**2)** The WAF ACL attached to the CloudFront distribution inspects the inbound traffic. If allowed, WAF forwards the traffic to the ALB which only accepts traffic from CloudFront's managed prefix list.

**3)** The ALB forwards the traffic in a distributed manner to the healthy, backend EC2 instances which host the web application.

**4)** The web site is served to the client while CloudFront caches the served content.

## Usage
This code assumes that you have already Terraform installed locally. For instructions on how to install Terraform, please refer to Hashicorp's documentation [here](https://developer.hashicorp.com/terraform/install).

To deploy this solution, please follow the instructions below.

**1)** Clone the repository locally:

```
git clone https://github.com/nick22d/ddos-resilient-architecture-webapp.git
```

**2)** Navigate into the repository:

```
cd ddos-resilient-architecture-webapp/
```

**3)** Run the following commands in the order written:

```
terraform init
```

```
terraform apply --auto-approve
```

**4)** Verify functionality by browsing to the DNS name of the CloudFront distribution returned in the output with the command below:

```
curl http://<dns name of the CloudFront distribution>
```  

## Roadmap

A set of WAF rules will be created and added to the 'edge' web ACL for protection against L7-based DDoS attacks.