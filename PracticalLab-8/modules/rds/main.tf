resource "aws_db_subnet_group" "db_subnet_group" {
  name       = var.db_subnet_group_name
  subnet_ids = var.subnet_ids

  tags = {
    Name = var.db_subnet_group_name
  }
}

resource "aws_db_parameter_group" "db_parameter_group" {
  name   = var.db_parameter_group_name
  family = var.db_family
}

resource "aws_db_instance" "postgres_db" {
  identifier             = var.db_identifier
  engine                 = "postgres"
  engine_version         = var.db_engine_version
  instance_class         = var.db_instance_class
  allocated_storage      = var.db_storage
  username              = var.db_username
  password              = var.db_password
  db_subnet_group_name   = aws_db_subnet_group.db_subnet_group.name
  parameter_group_name   = aws_db_parameter_group.db_parameter_group.name
  vpc_security_group_ids = var.vpc_security_group_ids  # Get from security module
  publicly_accessible    = var.publicly_accessible
  skip_final_snapshot    = true

  tags = {
    Name = var.db_identifier
  }
}
