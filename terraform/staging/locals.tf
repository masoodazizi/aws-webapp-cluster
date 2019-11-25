locals {
  env = "staging"

  project                = "${data.terraform_remote_state.global.project}"
  developer              = "${data.terraform_remote_state.global.developer}"
  terraform_state_bucket = "${data.terraform_remote_state.global.terraform_state_bucket}"

  vpc_cidr_block        = "10.10.0.0/16"
  private_subnets_cidrs = ["10.10.10.0/24", "10.10.11.0/24"]
  public_subnets_cidrs  = ["10.10.20.0/24", "10.10.21.0/24"]

  curr_year = "2019"
  iac       = "terraform"

  tags = {
    Environment = "${local.env}"
    Developer   = "${local.developer}"
    Project     = "${local.project}"
    ManagedBy   = "${local.iac}"
    DeployYear  = "${local.curr_year}"

    # DeployYear  = "${formatdate("YYYY")}"
  }
}
