resource "aws_ecs_cluster" "this" {
  name = "${var.env}_cluster"
  tags = "${merge(var.tags, map("Name", "${var.env}_cluster"))}"
}
