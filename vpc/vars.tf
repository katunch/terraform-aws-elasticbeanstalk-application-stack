variable "vpc_cidr_block" {
  type        = string
  description = "VPC CIDR block"
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidrs" {
  type        = list(string)
  description = "Public subnet CIDRs"
  default     = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
}

variable "private_subnet_cidrs" {
  type        = list(string)
  description = "Private subnet CIDRs"
  default     = ["10.0.4.0/24", "10.0.5.0/24", "10.0.6.0/24"]
}
variable "availability_zones" {
  type        = list(string)
  description = "Availability zones"
  default     = ["eu-central-1a", "eu-central-1b", "eu-central-1c"]
}

variable "applicationName" {
  type = string
}