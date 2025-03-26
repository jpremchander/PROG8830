# ALB Outputs (modules/alb/outputs.tf)
output "alb_dns_name" {
  value = aws_lb.app_alb.dns_name
}