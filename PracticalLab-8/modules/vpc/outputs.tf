# VPC Outputs (modules/vpc/outputs.tf)
output "vpc_id" {
  value = aws_vpc.new_vpc.id
}

output "subnet_1a_id" {
  value = aws_subnet.public_subnet_1a.id
}

output "subnet_1b_id" {
  value = aws_subnet.public_subnet_1b.id
}