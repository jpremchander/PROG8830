Terraform Practical Lab 8:

Description:

The project highlights some of the advanced capabilities of Terraform such as loops (count and for_each), functions, expressions, and modular configurations. The infrastructure configuration is given below:

* Multiple EC2 instances launched using loops.

* Dynamic ingress and egress rules in security groups.

* VPC configuration with internet gateway, subnets, and route tables.

* ALB (Application Load Balancer) to route traffic to EC2 instances.

* Terraform built-in functions for greater automation, flexibility, and reusability.

Prerequisites:

* Terraform CLI installed

* AWS credentials configuration (using AWS CLI or environment variables)

* Terraform fundamentals familiarity (e.g., providers, resources, modules, and state) 

Project Structure:

/Practical-Lab-8/
  ├── main.tf                # Master configuration to tie everything together
  └── variables.tf           # Master variables, e.g., VPC CIDR, EC2 configurations, etc.
├── outputs.tf             # Root outputs, like instance IDs and ALB DNS
  ├── modules/               # Modular code for EC2, security, and VPC
│   ├── ec2/               # Module to spin up multiple instances in EC2
  │   │   ├── main.tf
  │   │   ├── variables.tf
  │   │   ├── outputs.tf
│   ├── security/      # Security module to create security groups
  │   │   ├── main.tf
  │   │   ├── variables.tf
  │   │   ├── outputs.tf
│   └── vpc/          # module for creating VPC, subnets, and IGW
  │       ├── main.tf
  │       ├── variables.tf
  │       ├── outputs.tf
│   ├── alb/               # Module for Application Load Balancer creation
  │   │   ├── main.tf
  │   │   ├── variables.tf
  │   │   ├── outputs.tf
├── README.md              # Projektbeschreibung, Anleitung und Informationen

Terraform commands to execute:

1. Initialize Terraform Configurations in backend:

# terraform init

2. Plan infrastructure for your AWS Provider based on the configuration scripts:

# terraform plan

3. Apply the configuration to create the resources:

# terraform apply

4. Destroy the resources when complete (Optional – if any modifications or to clean out):

# terraform destroy

Terraform Loops (count and for_each)
count: To create lots of similar resources, e.g., EC2 instances. It's suitable when you want to repeat the same resource lots of times.

Example:

resource "aws_instance" "example" {
  count         = 3
ami           = var.ami_id
  instance_type = var.instance_type
}

for_each: Used to create dynamic resources from a map or set of values. This is more flexible than count, particularly when creating resources with different configurations.

Example:

resource "aws_security_group" "sg" {
  for_each = var.security_group_rules

  name_prefix = each.key
  vpc_id      = var.vpc_id

  ingress {
from_port   = each.value.from_port
    to_port     = each.value.to_port
    protocol    = each.value.protocol
    cidr_blocks = each.value.cidr_blocks
  }

Functions in Terraform Configurations

In this project, several useful Terraform functions are demonstrated:

String functions:

upper(): Converts all input strings to upper case.

lower(): Converts all input strings to lower case.

Numeric functions:

min(): Returns the lowest of a series of numbers.

max(): Gives the maximum of a list of numbers.

Collection functions:

concat(): Merges several lists or sets.

length(): Returns the length of a list, string, or map.

Networking functions:
cidrsubnet(): Generates a new subnet within a given CIDR block.

Example of cidrsubnet() use:

locals {
  new_subnet_cidr = cidrsubnet(var.cidr_block, 8, 1)
}
Better Configurations
Modularization: The code is broken down into reusable modules (ec2, security, vpc, and alb). Each module manages a specific section of the infrastructure.

Example:

ec2: Creates EC2 instances.

security: Creates security groups with dynamic ingress/egress rules.

vpc: Creates VPC, subnets, internet gateway, and route tables.

alb: Creates an Application Load Balancer (ALB) to load balance traffic to EC2 instances.

Dynamic Expressions: Terraform allows dynamic blocks to be used for creating dynamic content, such as creating dynamic ingress rules using variables.

Example:

resource "aws_security_group" "example" {
  dynamic "ingress" {
    for_each = var.ingress_rules
content {
      from_port   = ingress.value.from_port
      to_port     = ingress.value.to_port
      protocol    = ingress.value.protocol
      cidr_blocks = ingress.value.cidr_blocks
    }
  }
}
ALB (Application Load Balancer) Module
The ALB (Application Load Balancer) module is responsible for:

Creating an Application Load Balancer to direct traffic to several EC2 instances.

Declaring target groups to send traffic to the instances.

Declaring listeners on the load balancer to listen on specific ports.

Sample ALB configuration:

resource "aws_lb" "app_alb" {
  name               = "app-alb"
  internal           = false
load_balancer_type = "application"
  security_groups    = [var.lb_sg_id]
  subnets            = [var.subnet_1a_id, var.subnet_1b_id]
}

resource "aws_lb_target_group" "tg" {
  name     = "app-targetgroup"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id
}

resource "aws_lb_target_group_attachment" "attach" {
  target_group_arn = aws_lb_target_group.tg.arn
target_id        = var.instance_id
port             = 80

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.app_alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
type             = "forward"
    target_group_arn = aws_lb_target_group.tg.arn
  }

Lessons Learned:
count vs for_each: count is convenient for establishing similar resources, whereas for_each is versatile and can support different configurations based on maps or sets.

Terraform Functions: Functions in Terraform assist in furthering the automation of resource provisioning, making code more readable, reusable, and maintainable.

Modularization: The use of modules in Terraform promotes better organization of code, scalability, and reusability. Big infrastructure configurations are more manageable and maintainable.

ALB: The Application Load Balancer module plays a central role in load balancing traffic among several EC2 instances. It is simple to scale and configure according to the dynamic needs of your application.

Repository
[GitHub Repo Link - https://github.com/jpremchander/PROG8830.git]

Created By
Group 2

Members:
Prem Chander Jebastian
Rishi Patel
Twinkle Mishra