variable "cidr_block" {
  description = "The CIDR block for the VPC"
  type        = string
}

variable "subnet_cidr_1a" {
  description = "The CIDR block for subnet in AZ 1a"
  type        = string
}

variable "subnet_cidr_1b" {
  description = "The CIDR block for subnet in AZ 1b"
  type        = string
}

variable "ami_id" {
  description = "The AMI ID to use for EC2 instance"
  type        = string
}

variable "instance_type" {
  description = "The type of EC2 instance"
  type        = string
}
