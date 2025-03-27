Terraform Practical Lab 8

Description:

The project highlights some of the advanced capabilities of Terraform such as loops (count and for_each) functions, expressions, and modular configurations. The infrastructure configuration is given below:

Multiple EC2 instances launched using loops.

Dynamic ingress and egress rules in security groups.

VPC configuration with internet gateway, subnets, and route tables.

ALB (Application Load Balancer) to route traffic to EC2 instances.

RDS (Relational Database Service) setup with security group and subnet groups.

Terraform built-in functions for greater automation, flexibility, and reusability.

Prerequisites:

Terraform CLI installed

AWS credentials configuration (using AWS CLI or environment variables)

Terraform fundamentals familiarity (e.g., providers, resources, modules, and state)

Project Structure:

/Practical-Lab-8/
  ├── main.tf                # Main configuration to tie everything together
  ├── variables.tf           # Main variables, e.g., VPC CIDR, EC2 configurations, etc.
  ├── outputs.tf             # Outputs, like instance IDs and ALB DNS
  ├── modules/               # Modular code for EC2, security, VPC, ALB, and RDS
│   ├── ec2/               # Module to spin up multiple instances in EC2
  │   │   ├── main.tf
  │   │   ├── variables.tf
  │   │   ├── outputs.tf
│   ├── security/      # Security module to create security groups
  │   │   ├── main.tf
  │   │   ├── variables.tf
  │   │   ├── outputs.tf
│   ├── vpc/          # Module for creating VPC, subnets, and IGW
  │   │   ├── main.tf
  │   │   ├── variables.tf
  │   │   ├── outputs.tf
│   ├── alb/               # Module for Application Load Balancer creation
  │   │   ├── main.tf
  │   │   ├── variables.tf
  │   │   ├── outputs.tf
│   ├── rds/               # Module for RDS instance creation
  │   │   ├── main.tf
  │   │   ├── variables.tf
  │   │   ├── outputs.tf
├── README.md              # Project Description

Terraform commands to execute:

Initialize Terraform Configurations in backend:

terraform init

Plan infrastructure for your AWS Provider based on the configuration scripts:

terraform plan

Apply the configuration to create the resources:

terraform apply

Destroy the resources when complete (Optional – if any modifications or to clean out):

terraform destroy

Terraform Loops (count and for_each)

count:

To create lots of similar resources, e.g., EC2 instances.

resource "aws_instance" "example" {
  count         = 3
  ami           = var.ami_id
  instance_type = var.instance_type
}

for_each:

Used to create dynamic resources from a map or set of values.

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

Functions in Terraform Configurations

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

locals {
  new_subnet_cidr = cidrsubnet(var.cidr_block, 8, 1)
}

RDS (Relational Database Service) Module

The RDS module is responsible for:

Creating an RDS PostgreSQL instance with necessary security configurations.

Attaching an RDS security group with controlled ingress/egress rules.

Placing the RDS instance within the correct subnet group.

Sample RDS Configuration:

resource "aws_db_instance" "rds_instance" {
  identifier              = "rds-instance"
  engine                 = "postgres"
  engine_version         = "16.3"
  instance_class         = "db.t3.micro"
  allocated_storage      = 5
  username              = "pgadmin"
  password              = "pgadmin2k25"
  publicly_accessible    = true
  vpc_security_group_ids = [module.security.rds_security_group_id]
  db_subnet_group_name   = "public-db-subnet-group"
}

Lessons Learned:

Terraform Functions:

Using functions in Terraform can be beneficial as they help automate processes, simplify your code, and enhance reusability.

Modularization:

Modularizing your Terraform code enhances organization and logic flow. It’s like constructing a building using blocks.

ALB:

The Application Load Balancer module is the best example of a load balancer for traffic distributed to multiple EC2 instances.

RDS Security:

Managing RDS security groups separately ensures controlled database access, preventing unauthorized exposure.

Repository

[GitHub Repo Link - https://github.com/jpremchander/PROG8830.git]

Created By:

Group 2

Members:
Prem Chander Jebastian
Rishi Patel
Twinkle Mishra
