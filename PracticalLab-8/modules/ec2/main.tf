# EC2 Module (modules/ec2/main.tf)
resource "aws_instance" "practicallab4_ec2_server" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  subnet_id              = var.subnet_id
  vpc_security_group_ids = [var.security_group_id]

  user_data = <<-EOF
  #!/bin/bash
  yum install -y httpd
  echo "Hello from Group2!" > /var/www/html/index.html
  systemctl start httpd
  systemctl enable httpd
  EOF
}