output "private_servers" {
  value = aws_instance.Private-Servers.*.id
}

output "public_servers" {
  value = aws_instance.Public-Servers.*.id
}

