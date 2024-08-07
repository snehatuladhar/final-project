output "alb_arn" {
  value = aws_lb.my_alb.arn
}

output "zone_id" {
  value = aws_lb.my_alb.zone_id
}

output "dns_name" {
  value = aws_lb.my_alb.dns_name
}
