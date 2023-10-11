output "vpc_id" {
  description = "The VPC ID"
  value       = aws_vpc.main.id
}

output "public_subnets" {
  description = "The public subnets"
  value       = aws_subnet.public_subnets[*].id
}

output "private_subnets" {
  description = "The private subnets"
  value       = aws_subnet.private_subnets[*].id
}

output "internet_gateway" {
  description = "The internet gateway"
  value       = aws_internet_gateway.gw.id
}

output "availability_zones" {
  description = "The availability zones"
  value       = aws_subnet.public_subnets[*].availability_zone
}

output "cidr_block" {
  description = "The CIDR block of the VPC"
  value       = aws_vpc.main.cidr_block
}
