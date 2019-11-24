####################################################
# S3 backend defined as the terraform remote state
# INTERPOLATION is not ALLOWED!
# S3 bucket should be created manually in advance
# Update the bucket name accordingly
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
    bucket  = "myproject-terraform-remote-state"
    key     = "staging/terraform.tfstate"
    encrypt = true
  }
}

# data "terraform_remote_state" "global" {
#   backend = "s3"
#
#   config {
#     bucket  = "myproject-terraform-remote-state"
#     key     = "global/terraform.tfstate"
#     region  = "${var.aws_region}"
#     profile = "${var.aws_profile}"
#   }
# }

