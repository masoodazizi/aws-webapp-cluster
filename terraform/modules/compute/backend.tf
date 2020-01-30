data "terraform_remote_state" "global" {
  backend = "s3"

  config = {
    bucket  = var.terraform_state_bucket
    key     = "global/terraform.tfstate"
    region  = var.aws_region
    profile = var.aws_profile
  }
}

