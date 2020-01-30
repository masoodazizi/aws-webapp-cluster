########## ECS ALB SECURITY GROUP ##########

resource "aws_security_group" "ecs_alb" {
  name        = "${var.env}-ecs-alb-sg"
  description = "Controls traffic to/from ECS Cluster in the ${var.env} environment"
  vpc_id      = var.vpc_id
  tags = merge(
    var.tags,
    {
      "Name" = "${var.env}_ecs_alb_sg"
    },
  )
}

resource "aws_security_group_rule" "ecs_alb_ingress_bastion" {
  type      = "ingress"
  from_port = 0
  to_port   = 0
  protocol  = "-1"

  security_group_id        = aws_security_group.ecs_alb.id
  source_security_group_id = aws_security_group.bastion.id
}

resource "aws_security_group_rule" "ecs_alb_egress" {
  type        = "egress"
  from_port   = 0
  to_port     = 0
  protocol    = "-1"
  cidr_blocks = ["0.0.0.0/0"]

  security_group_id = aws_security_group.ecs_alb.id
}

########## ECS INSTANCE SECURITY GROUP ##########

resource "aws_security_group" "ecs_instance" {
  name        = "${var.env}-ecs-instance-sg"
  description = "Controls traffic to/from ECS instances in the ${var.env} environment"
  vpc_id      = var.vpc_id
  tags = merge(
    var.tags,
    {
      "Name" = "${var.env}_ecs_instance_sg"
    },
  )
}

resource "aws_security_group_rule" "ecs_instance_ingress_alb" {
  type      = "ingress"
  from_port = 0
  to_port   = 0
  protocol  = "-1"

  security_group_id        = aws_security_group.ecs_instance.id
  source_security_group_id = aws_security_group.ecs_alb.id
}

resource "aws_security_group_rule" "ecs_instance_ingress_bastion" {
  type      = "ingress"
  from_port = 0
  to_port   = 0
  protocol  = "-1"

  security_group_id        = aws_security_group.ecs_instance.id
  source_security_group_id = aws_security_group.bastion.id
}

resource "aws_security_group_rule" "ecs_instance_egress" {
  type        = "egress"
  from_port   = 0
  to_port     = 0
  protocol    = "-1"
  cidr_blocks = ["0.0.0.0/0"]

  security_group_id = aws_security_group.ecs_instance.id
}

########## BASTION HOST SECURITY GROUP ##########

resource "aws_security_group" "bastion" {
  name        = "${var.env}-bastion-sg"
  description = "Controls traffic to/from the bastion host in the ${var.env} environment"
  vpc_id      = var.vpc_id
  tags = merge(
    var.tags,
    {
      "Name" = "${var.env}_bastion_sg"
    },
  )
}

resource "aws_security_group_rule" "bastion_ingress_maintenance" {
  type      = "ingress"
  from_port = 0
  to_port   = 0
  protocol  = "-1"

  security_group_id        = aws_security_group.bastion.id
  source_security_group_id = aws_security_group.maintenance.id
}

resource "aws_security_group_rule" "ecs_alb_egress" {
  type        = "egress"
  from_port   = 0
  to_port     = 0
  protocol    = "-1"
  cidr_blocks = ["0.0.0.0/0"]

  security_group_id = aws_security_group.bastion.id
}

########## MAINTENANCE SECURITY GROUP ##########

resource "aws_security_group" "maintenance" {
  name        = "${var.env}-maintenance-sg"
  description = "Allows external access to the resources in the ${var.env} environment"
  vpc_id      = var.vpc_id
  tags = merge(
    var.tags,
    {
      "Name" = "${var.env}_maintenance_sg"
    },
  )
}

resource "aws_security_group_rule" "maintenance_ingress_ips" {
  type        = "ingress"
  from_port   = 0
  to_port     = 0
  protocol    = "-1"
  cidr_blocks = var.access_cidrs

  security_group_id = aws_security_group.bastion.id
}

resource "aws_security_group_rule" "ecs_alb_egress" {
  type        = "egress"
  from_port   = 0
  to_port     = 0
  protocol    = "-1"
  cidr_blocks = ["0.0.0.0/0"]

  security_group_id = aws_security_group.bastion.id
}

