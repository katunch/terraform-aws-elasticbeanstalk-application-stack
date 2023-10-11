output "public_ip" {
  value       = aws_instance.bastion.public_ip
  description = "Public IP of the bastion host"
}

output "public_dns" {
  value       = aws_instance.bastion.public_dns
  description = "Public DNS of the bastion host"
}

output "ssh_key_name" {
  value = aws_instance.bastion.key_name
}