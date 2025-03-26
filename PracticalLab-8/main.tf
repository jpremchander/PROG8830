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
