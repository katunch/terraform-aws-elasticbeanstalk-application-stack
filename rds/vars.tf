variable "applicationName" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "ingress_cidr_blocks" {
  type = list(string)
}

variable "db_engine" {
  type    = string
  default = "aurora-mysql"
}

variable "db_engine_version" {
  type    = string
  default = "8.0.mysql_aurora.3.04.0"
}

variable "availability_zones" {
  type        = list(string)
  description = "Availability zones"
}

variable "subnets" {
  type        = list(string)
  description = "Subnets"
}

variable "db_admin_username" {
  type    = string
  default = "admin"
}

variable "db_default_scheme" {
  type    = string
  default = "ebdb"
}

variable "db_instance_class" {
  type    = string
  default = "db.t3.medium"
}