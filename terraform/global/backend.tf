####################################################
# S3 backend defined as the terraform remote state
# INTERPOLATION is not ALLOWED!
# S3 bucket should be created manually in advance
# Update the bucket name accordingly and ...
# change the local `terraform_state_bucket` as well.
#
# These two parameters are defined in init:
#   * profile="aws_profile"
#   * region="aws_region"
# init command example:
# $ terraform init \
#    -backend-config="profile=aws_profile" \
#    -backend-config="region=aws_region"
# reference:
# https://www.terraform.io/docs/backends/config.html
####################################################

terraform {
  backend "s3" {
    # NOTE: change the local 'terraform_state_bucket' too.
    bucket         = "myproject-terraform-remote-state"
    key            = "global/terraform.tfstate"
    dynamodb_table = "myproject-terraform-state-locks"
    encrypt        = true
  }
}

data "terraform_remote_state" "init_state" {
  backend = "local"

  config {
    path = "./init/terraform.tfstate"
  }
}
