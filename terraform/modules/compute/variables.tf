variable "env" {}
variable "region" {}
variable "profile" {}
variable "terraform_state_bucket" {}

variable "private_subnets" {}

variable "public_subnets" {}

variable "access_cidrs" {
  default     = [""]
  description = "List of CIDRS of public IP addresses accessing to the resources"
}

variable "instance_type" {
  default = "t3.medium"
}
