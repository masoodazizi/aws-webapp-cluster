resource "aws_alb" "ecs_alb" {
  name            = "${var.env}_ecs_alb"
  internal        = false
  subnets         = ["${split(",", var.public_subnets)}"]
  security_groups = ["${aws_security_group.ecs_alb.id}"]

  access_logs {
    bucket   = "${data.terraform_remote_state.global.alb_logs_bucket}"
    prefix   = "${var.env}-ecs-alb"
    interval = 60
    enabled  = false
  }

  tags = "${merge(var.tags, map("Name", "${var.env}_ecs_alb"))}"
}

resource "aws_launch_configuration" "ecs_lc" {
  key_name      = "${data.terraform_remote_state.global.ssh_key}"
  name_prefix   = "${var.env}-ecs-instance"
  image_id      = "${data.aws_ssm_parameter.ecs_optimized_image_id.value}"
  instance_type = "${var.instance_type}"
}

data "aws_ssm_parameter" "ecs_optimized_image_id" {
  name = "/aws/service/ecs/optimized-ami/amazon-linux-2/recommended/image_id"
}
