variable "db_subnet_group_name" {
  description = "Name of the RDS subnet group"
  type        = string
}

variable "subnet_ids" {
  description = "List of subnet IDs for the RDS instance"
  type        = list(string)
}

variable "db_parameter_group_name" {
  description = "Name of the RDS parameter group"
  type        = string
}

variable "db_family" {
  description = "Database family for parameter group"
  type        = string
}

variable "db_identifier" {
  description = "Unique identifier for the RDS instance"
  type        = string
}

variable "db_engine_version" {
  description = "Database engine version"
  type        = string
}

variable "db_instance_class" {
  description = "Instance type for the RDS instance"
  type        = string
}

variable "db_storage" {
  description = "Allocated storage for the RDS instance (in GB)"
  type        = number
}

variable "db_username" {
  description = "Username for the RDS instance"
  type        = string
}

variable "db_password" {
  description = "Password for the RDS instance"
  type        = string
}

variable "vpc_security_group_ids" {
  description = "List of security group IDs to attach to RDS"
  type        = list(string)
}

variable "publicly_accessible" {
  description = "Whether the RDS instance should be publicly accessible"
  type        = bool
}
