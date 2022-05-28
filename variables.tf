variable "public_ssh_key" {
  type = string
}

variable "private_ssh_key" {
  type = string
}

variable "ssh_user" {
  type = string
}

variable "password"{
  type = string
}
variable "vpc_cidr_block" {
  type = string
  default = "10.0.0.0/16"
}

variable "subnet_cidr_block" {
  type = string
  default = "10.0.1.0/24"
}