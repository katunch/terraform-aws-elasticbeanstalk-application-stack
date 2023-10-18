variable "applicationName" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "vpc_cidr_block" {
  type = string
}

variable "domain_name" {
  type = string
}
variable "ssl_cert_arn" {
  type = string
}

variable "solution_stack_name" {
  type    = string
  default = "64bit Amazon Linux 2 v4.3.12 running Tomcat 8.5 Corretto 8"
}
variable "environment_name" {
  type    = string
  default = "eb-environment"
}

variable "instance_type" {
  type    = string
  default = "t4g.micro"
}
variable "ssh_key_name" {
  type = string
}
variable "subnets" {
  type = list(string)
}
variable "elb_subnets" {
  type = list(string)
}

variable "min_instance_count" {
  type    = number
  default = 1
}

variable "max_instance_count" {
  type    = number
  default = 1
}

variable "environment_variables" {
  type    = map(string)
  default = {}
}

variable "eb_settings" {
  type = list(object({
    namespace = string
    name      = string
    value     = string
  }))
  default = []
}