resource "aws_security_group" "web_sg" {
  for_each = var.security_groups

  name_prefix = each.key
  vpc_id      = var.vpc_id

  dynamic "ingress" {
    for_each = each.value
    content {
      from_port   = ingress.value["from_port"]
      to_port     = ingress.value["to_port"]
      protocol    = ingress.value["protocol"]
      cidr_blocks = ingress.value["cidr_blocks"]
    }
  }
}