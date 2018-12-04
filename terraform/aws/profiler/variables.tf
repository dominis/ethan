variable "region" {}

variable "servers_per_az" {
  default = 1
}

variable "instance_type" {
  default = "t2.nano"
}

variable "redis_password" {}
variable "redis_host" {}
variable "test_host" {}

variable "test_count" {
  default = 25
}

variable "ssh_key" {}
