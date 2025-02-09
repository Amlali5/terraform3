output "public_lb_dns" {
  value = aws_lb.public.dns_name
}

output "private_lb_dns" {
  value = aws_lb.private.dns_name
}
