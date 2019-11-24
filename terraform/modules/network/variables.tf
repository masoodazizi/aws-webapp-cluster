variable "env" {}

variable "cidr_block" {
  description = "Defines the CIDR for the whole VPC"
  default     = ""
}

variable "tags" {
  type = "map"
}

variable "public_subnets_cidrs" {
  default     = [""]
  description = "Comma separated list of subnets"
}

variable "private_subnets_cidrs" {
  default     = [""]
  description = "Comma separated list of subnets"
}
