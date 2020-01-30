resource "aws_ecs_cluster" "this" {
  name = "${var.env}_cluster"
  tags = merge(
    var.tags,
    {
      "Name" = "${var.env}_cluster"
    },
  )
}

