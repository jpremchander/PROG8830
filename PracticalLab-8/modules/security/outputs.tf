# Security Outputs (modules/security/outputs.tf)
output "lb_sg_id" {
  value = aws_security_group.lb_sg.id
}

output "ec2_sg_id" {
  value = aws_security_group.ec2_sg.id
}

output "rds_sg_id" {
  value = aws_security_group.rds_sg.id
}