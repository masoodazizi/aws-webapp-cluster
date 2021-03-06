output "terraform_state_bucket" {
  value = data.terraform_remote_state.init_state.outputs.terraform_state_bucket
}

output "ssh_key" {
  value = data.terraform_remote_state.init_state.outputs.ssh_key
}

output "alb_logs_bucket" {
  value = aws_s3_bucket.alb_access_logs.id
}

output "project" {
  value = local.project
}

output "developer" {
  value = local.developer
}

##### IAM ROLES

output "ecs_instance_role_name" {
  value = aws_iam_role.ecs_instance_role.name
}

output "ecs_service_role_name" {
  value = aws_iam_role.ecs_service_role.name
}

output "ecs_service_autoscale_role_arn" {
  value = aws_iam_role.ecs_service_autoscale_role.arn
}

