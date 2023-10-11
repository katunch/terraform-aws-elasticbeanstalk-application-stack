variable "applicationName" {
  type = string
}

variable "applicationEnvironment" {
  type = string
}

variable "dns_name" {
  type        = string
  description = "Domain name"
}

variable "ssl_cert_arn" {
  type        = string
  description = "The ARN of the SSL certificate"
}

variable "aws_region" {
  type    = string
  default = "eu-central-1"
}

variable "aws_profile" {
  type    = string
  default = "default"
}

variable "ssh_public_key_path" {
  type        = string
  description = "Path to public key"
  default     = "~/.ssh/id_rsa.pub"
}

variable "jira_key" {
  type        = string
  description = "Jira key"
  default     = "NOPE"
}

variable "availability_zones" {
  type        = list(string)
  description = "List of availability zones"
  default     = ["eu-central-1a", "eu-central-1b", "eu-central-1c"]
}

variable "vpc_cidr_block" {
  type        = string
  description = "VPC CIDR block"
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidrs" {
  type        = list(string)
  description = "List of public subnet CIDRs"
  default     = ["10.0.0.0/24", "10.0.1.0/24", "10.0.2.0/24"]
}

variable "private_subnet_cidrs" {
  type        = list(string)
  description = "List of private subnet CIDRs"
  default     = ["10.0.3.0/24", "10.0.4.0/24", "10.0.5.0/24"]
}

variable "eb_solution_stack_name" {
  type        = string
  description = "Solution stack name"
  default     = "64bit Amazon Linux 2 v4.3.12 running Tomcat 8.5 Corretto 8"
}

variable "eb_instance_type" {
  type        = string
  description = "Instance type"
  default     = "t4g.micro"
}