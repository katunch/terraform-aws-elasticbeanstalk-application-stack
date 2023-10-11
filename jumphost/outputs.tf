output "public_ip" {
  value       = aws_instance.jumphost.public_ip
  description = "Public IP of the jumphost"
}

output "public_dns" {
  value       = aws_instance.jumphost.public_dns
  description = "Public DNS of the jumphost"
}

output "ssh_key_name" {
  value = aws_instance.jumphost.key_name
}