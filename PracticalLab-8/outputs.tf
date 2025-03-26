output "vpc_id" {
  value = module.vpc.vpc_id
}

output "subnet_1a_id" {
  value = module.vpc.subnet_1a_id
}

output "subnet_1b_id" {
  value = module.vpc.subnet_1b_id
}

output "lb_sg_id" {
  value = module.security.lb_sg_id
}

output "ec2_sg_id" {
  value = module.security.ec2_sg_id
}

output "instance_id" {
  value = module.ec2.instance_id
}

output "alb_dns_name" {
  value = module.alb.alb_dns_name
}
