variable "vpc_id" {}

variable "ec2_sg_name" {
  default = "ec2-security-group"
}

variable "lb_sg_name" {
  default = "lb-security-group"
}

variable "rds_sg_name" {
  default = "rds-security-group"
}

variable "allowed_cidr_blocks" {
  type    = list(string)
  default = ["0.0.0.0/0"]
}
