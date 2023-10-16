variable "applicationName" {
  type = string
}
variable "opensearch_engine_version" {
  type = string
}

variable "instance_count" {
  type    = number
  default = 1
}

variable "eb_storage_type" {
  type    = string
  default = "gp2"
}

variable "eb_storage_size" {
  type    = number
  default = 20
}

variable "instance_type" {
  type    = string
  default = "t3.medium.search"
}

variable "vpc_id" {
  type = string
}
variable "domain" {
  type    = string
  default = "customers"
}

variable "opensearch_master_user" {
  type    = string
  default = "domain-master"
}