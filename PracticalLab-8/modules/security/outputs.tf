output "ec2_security_group_id" {
  value = aws_security_group.ec2_sg.id
}

output "lb_security_group_id" {
  value = aws_security_group.lb_sg.id
}

output "rds_security_group_id" {
  value = aws_security_group.rds_sg.id
}
