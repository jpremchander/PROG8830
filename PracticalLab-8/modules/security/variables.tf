# Security Variables (modules/security/variables.tf)
variable "vpc_id" {}

variable "rds_sg_name" {
  description = "Name of the RDS security group"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID where the security group will be created"
  type        = string
}

variable "allowed_cidr_blocks" {
  description = "Allowed CIDR blocks for RDS security group"
  type        = list(string)
}

