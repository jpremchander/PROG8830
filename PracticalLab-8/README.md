Terraform Practical Lab 8:

Description:

This project demonstrates advanced Terraform features such as loops (count and for_each), functions, expressions, and modular configurations. The infrastructure setup includes:

Multiple EC2 instances created using loops.

Security groups with dynamic ingress and egress rules.

VPC setup with internet gateway, subnets, and route tables.

ALB (Application Load Balancer) for routing traffic to EC2 instances.

Terraform built-in functions for enhanced automation, flexibility, and reusability.

Prerequisites:

Terraform CLI installed

AWS credentials configured (via AWS CLI or environment variables)

Basic understanding of Terraform concepts (e.g., providers, resources, modules, and state)

Project Structure:

/Practical-Lab-8/
  ├── main.tf                # Root configuration to tie everything together
  ├── variables.tf           # Root variables, including VPC CIDR, EC2 settings, etc.
  ├── outputs.tf             # Outputs from root, including instance IDs and ALB DNS
  ├── modules/               # Modularized code for EC2, security, and VPC
  │   ├── ec2/               # EC2 module to launch multiple instances
  │   │   ├── main.tf
  │   │   ├── variables.tf
  │   │   ├── outputs.tf
  │   ├── security/          # Security module to define security groups
  │   │   ├── main.tf
  │   │   ├── variables.tf
  │   │   ├── outputs.tf
  │   ├── vpc/               # VPC module for creating VPC, subnets, and IGW
  │   │   ├── main.tf
  │   │   ├── variables.tf
  │   │   ├── outputs.tf
  │   ├── alb/               # ALB module for creating the Application Load Balancer
  │   │   ├── main.tf
  │   │   ├── variables.tf
  │   │   ├── outputs.tf
  ├── README.md              # Project description, instructions, and details


Terraform Commands to Execute:

1. Initialize Terraform Configurations in the backend:

# terraform init

2. Plan the infrastructure for your AWS Provider with the configuration scripts:

# terraform plan

3. Apply the configuration to create the resources:

# terraform apply

4. Destroy the resources when done (Optional – in case of any changes or to clean up):

# terraform destroy

Terraform Loops (count and for_each)

count: Used to create multiple identical resources, such as EC2 instances. It’s suitable when you want to replicate the same resource multiple times.

Example:

resource "aws_instance" "example" {
  count         = 3
  ami           = var.ami_id
  instance_type = var.instance_type
}

for_each: Used for creating dynamic resources based on a map or set of values. This is more flexible than count, especially when creating resources with unique configurations.

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
}

Functions Used in Terraform Configurations
This project demonstrates several useful Terraform functions:

String functions:

upper(): Converts strings to uppercase.

lower(): Converts strings to lowercase.

Numeric functions:

min(): Returns the minimum of a set of numbers.

max(): Returns the maximum of a set of numbers.

Collection functions:

concat(): Concatenates multiple lists or sets.

length(): Returns the length of a list, string, or map.

Networking functions:

cidrsubnet(): Generates a new subnet within a given CIDR block.

Example of using cidrsubnet():


locals {
  new_subnet_cidr = cidrsubnet(var.cidr_block, 8, 1)
}
Enhanced Configurations
Modularization: Code is organized into reusable modules (ec2, security, vpc, and alb). Each module is responsible for a specific part of the infrastructure.

For example:

ec2: Creates EC2 instances.

security: Defines security groups with dynamic ingress/egress rules.

vpc: Defines VPC, subnets, internet gateway, and route tables.

alb: Creates an Application Load Balancer (ALB) to distribute traffic to EC2 instances.

Dynamic Expressions: Terraform allows for the use of dynamic blocks to generate dynamic content, such as adding dynamic ingress rules based on variables.

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

Creating an Application Load Balancer to distribute traffic across multiple EC2 instances.

Configuring target groups for routing traffic to the instances.

Setting up listeners on the load balancer to listen on specific ports.

Example ALB configuration:

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
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.app_alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tg.arn
  }
}

Lessons Learned:

count vs for_each: count is useful for creating identical resources, while for_each is more flexible and can handle unique configurations based on maps or sets.

Terraform Functions: Functions in Terraform significantly improve the automation of resource provisioning, making the code more readable, reusable, and easier to maintain.

Modularization: Using modules in Terraform promotes better code organization, scalability, and reusability. It is easier to manage and maintain large infrastructure configurations.

ALB: The Application Load Balancer module is essential for load balancing traffic across multiple EC2 instances. It is easy to scale and configure based on the dynamic needs of your application.

Repository
[GitHub Repo Link - https://github.com/jpremchander/PROG8830.git]

Created By
Group 2

Members:
Prem Chander Jebastian
Rishi Patel
Twinkle Mishra