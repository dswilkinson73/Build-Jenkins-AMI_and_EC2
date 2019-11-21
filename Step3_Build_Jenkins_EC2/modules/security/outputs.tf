output "security_group_name" {
  description = "the security group name"
  value       = aws_security_group.dsw-sg.name
}
