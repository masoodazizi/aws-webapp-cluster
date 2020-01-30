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
  key_name             = "${data.terraform_remote_state.global.ssh_key}"
  name_prefix          = "${var.env}-ecs-instance"
  image_id             = "${data.aws_ssm_parameter.ecs_optimized_image_id.value}"
  instance_type        = "${var.instance_type}"
  iam_instance_profile = "${data.terraform_remote_state.global.ecs_instance_role_name}"
  security_groups      = ["${aws_security_group.ecs_instance.id}"]
  user_data            = "#!/bin/bash\necho ECS_CLUSTER=${var.cluster_name} > /etc/ecs/ecs.config"

  root_block_device {
    volume_type = "gp2"
    volume_size = "${var.root_volume_size}"
  }

  lifecycle {
    create_before_destroy = true
  }

  tags = "${merge(var.tags, map("Name", "${var.env}_ecs_lc"))}"
}

data "aws_ssm_parameter" "ecs_optimized_image_id" {
  name = "/aws/service/ecs/optimized-ami/amazon-linux-2/recommended/image_id"
}

resource "aws_autoscaling_group" "ecs_asg" {
  name                      = "${var.env}-ecs-cluster-autoscaling-group"
  vpc_zone_identifier       = ["${split(",", var.private_subnets)}"]
  launch_configuration      = "${aws_launch_configuration.ecs_cluster.name}"
  min_size                  = "${var.asg_min_size}"
  max_size                  = "${var.asg_max_size}"
  desired_capacity          = "${var.asg_desired_capacity}"
  min_elb_capacity          = 1
  health_check_grace_period = "${var.asg_health_check_grace_period}"
  health_check_type         = "${var.asg_health_check_type}"

  tags = [
    {
      key                 = "Name"
      value               = "${var.env}-ecs-instance"
      propagate_at_launch = true
    },
    {
      key                 = "Environment"
      value               = "${var.env}"
      propagate_at_launch = true
    },
    {
      key                 = "launch_configuration"
      value               = "${aws_launch_configuration.ecs_lc.name}"
      propagate_at_launch = true
    },
    {
      key                 = "Project"
      value               = "${lookup(var.tags, "project")}"
      propagate_at_launch = true
    },
    {
      key                 = "Developer"
      value               = "${lookup(var.tags, "developer")}"
      propagate_at_launch = true
    },
    {
      key                 = "ManagedBy"
      value               = "${lookup(var.tags, "iac")}"
      propagate_at_launch = true
    },
  ]
}
