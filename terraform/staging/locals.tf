locals {
  env       = "staging"
  curr_year = "2019"
  iac       = "terraform"

  tags = {
    Environment = "${local.env}"
    Developer   = "${var.developer}"
    Project     = "${var.project}"
    ManagedBy   = "${local.iac}"
    DeployYear  = "${local.curr_year}"

    # DeployYear  = "${formatdate("YYYY")}"
  }
}
