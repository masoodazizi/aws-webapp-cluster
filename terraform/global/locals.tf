locals {
  env = "global"

  curr_year = "2020"
  iac       = "terraform"

  project   = var.project
  developer = var.developer

  tags = {
    Environment = local.env
    Developer   = local.developer
    Project     = local.project
    ManagedBy   = local.iac
    DeployYear  = local.curr_year
  }
  # DeployYear  = "${formatdate("YYYY")}"
}
