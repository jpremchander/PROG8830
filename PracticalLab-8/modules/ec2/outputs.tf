# EC2 Outputs (modules/ec2/outputs.tf)
output "instance_id" {
  value = aws_instance.practicallab4_ec2_server.id
}