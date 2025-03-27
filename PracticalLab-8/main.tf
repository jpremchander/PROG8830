provider "aws" {
  region = "ca-central-1"
}

module "vpc" {
  source        = "./modules/vpc"
  cidr_block    = var.cidr_block
  subnet_cidr_1a = var.subnet_cidr_1a
  subnet_cidr_1b = var.subnet_cidr_1b
}

module "security" {
  source  = "./modules/security"
  vpc_id  = module.vpc.vpc_id
}

module "ec2" {
  source            = "./modules/ec2"
  ami_id            = var.ami_id
  instance_type     = var.instance_type
  subnet_id         = module.vpc.subnet_1a_id  # Assuming subnet_1a for EC2
  security_group_id = module.security.ec2_sg_id
}

module "alb" {
  source            = "./modules/alb"
  vpc_id            = module.vpc.vpc_id
  lb_sg_id          = module.security.lb_sg_id
  subnet_1a_id      = module.vpc.subnet_1a_id
  subnet_1b_id      = module.vpc.subnet_1b_id
  instance_id       = module.ec2.instance_id
}

module "security" {
  source               = "./modules/security"
  vpc_id               = module.vpc.vpc_id
  rds_sg_name          = "rds-security-group"
  allowed_cidr_blocks  = ["0.0.0.0/0"]
}

module "rds" {
  source                 = "./modules/rds"
  vpc_security_group_ids = [module.security.rds_security_group_id]  # Use security module output
  db_subnet_group_name   = "public-db-subnet-group"
  subnet_ids             = [module.vpc.public_subnet_1a, module.vpc.public_subnet_1b]
  db_parameter_group_name = "default-postgresql16"
  db_family              = "postgres16"
  db_identifier          = "localpostgresdb"
  db_engine_version      = "16.3"
  db_instance_class      = "db.t3.micro"
  db_storage             = 5
  db_username            = "pgadmin"
  db_password            = "pgadmin2k25"
  publicly_accessible    = true
}

