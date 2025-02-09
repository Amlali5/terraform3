output "public_instance_ids" {
  value = aws_instance.public[*].id
}

output "private_instance_ids" {
  value = aws_instance.private[*].id
}