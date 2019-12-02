output "terraform_state_bucket" {
  value = "${data.terraform_remote_state.init_state.terraform_state_bucket}"
}

output "ssh_key" {
  value = "${data.terraform_remote_state.init_state.ssh_key}"
}

output "alb_logs_bucket" {
  value = "${aws_s3_bucket.alb_access_logs.id}"
}

output "project" {
  value = "${local.project}"
}

output "developer" {
  value = "${local.developer}"
}
