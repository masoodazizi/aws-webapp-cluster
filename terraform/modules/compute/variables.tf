variable "env" {
}

variable "region" {
}

variable "profile" {
}

variable "terraform_state_bucket" {
}

variable "private_subnets" {
}

variable "public_subnets" {
}

variable "access_cidrs" {
  default     = [""]
  description = "List of CIDRS of public IP addresses accessing to the resources"
}

variable "instance_type" {
  default = "t3.micro"
}

variable "root_volume_size" {
  default = "10"
}

variable "cluster_name" {
}

variable "tags" {
  type = map(string)
}

##### AUTO SCALING GROUP VARIABLES

variable "asg_min_size" {
  default = "2"
}

variable "asg_max_size" {
  default = "5"
}

variable "asg_desired_capacity" {
  default = "3"
}

variable "asg_health_check_type" {
  default = "ELB"
}

variable "asg_health_check_grace_period" {
  default = "300"
}

