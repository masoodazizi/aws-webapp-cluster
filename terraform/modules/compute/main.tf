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
