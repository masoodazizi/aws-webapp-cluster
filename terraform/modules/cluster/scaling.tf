##### ECS Cluster Auto-Scaling: CPU Utilization
# tip: http://garbe.io/blog/2016/10/17/docker-on-ecs-scale-your-ecs-cluster-automatically/#rule-of-thumb

resource "aws_autoscaling_policy" "ecs_cluster_cpu_high" {
  name                   = "${aws_ecs_cluster.this.name}_cpu-reservation_high"
  scaling_adjustment     = var.scaling_adjustment
  adjustment_type        = "ChangeInCapacity"
  cooldown               = var.up_cooldown
  autoscaling_group_name = var.auto_scaling_group_name
}

resource "aws_cloudwatch_metric_alarm" "ecs_cluster_cpu_high" {
  alarm_name          = "${aws_ecs_cluster.this.name}_cpu-reservation_high"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = var.cpu_high_evaluation_periods
  metric_name         = "CPUReservation"
  namespace           = "AWS/ECS"
  period              = var.cpu_high_period
  statistic           = var.cpu_high_statistic
  threshold           = var.cpu_high_threshold

  dimensions = {
    ClusterName = aws_ecs_cluster.this.name
  }

  alarm_actions = [aws_autoscaling_policy.ecs_cluster_cpu_high.arn]
}

resource "aws_cloudwatch_metric_alarm" "ecs_cluster_cpu_low" {
  alarm_name          = "${aws_ecs_cluster.this.name}_cpu-reservation_low"
  comparison_operator = "LessThanThreshold"
  evaluation_periods  = var.cpu_low_evaluation_periods
  metric_name         = "CPUReservation"
  namespace           = "AWS/ECS"
  period              = var.cpu_low_period
  statistic           = var.cpu_low_statistic
  threshold           = var.cpu_low_threshold

  dimensions = {
    ClusterName = aws_ecs_cluster.this.name
  }
}

##### ECS Cluster Auto-Scaling: RAM Utilization

resource "aws_autoscaling_policy" "ecs_cluster_ram_high" {
  name                   = "${var.cluster_name}_ram-reservation_high"
  scaling_adjustment     = var.scaling_adjustment
  adjustment_type        = "ChangeInCapacity"
  cooldown               = var.up_cooldown
  autoscaling_group_name = var.auto_scaling_group_name
}

### Metric Alarms ###

resource "aws_cloudwatch_metric_alarm" "ecs_cluster_ram_high" {
  alarm_name          = "${var.cluster_name}_ram-reservation_high"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = var.ram_high_evaluation_periods
  metric_name         = "MemoryReservation"
  namespace           = "AWS/ECS"
  period              = var.ram_high_period
  statistic           = var.ram_high_statistic
  threshold           = var.ram_high_threshold

  dimensions = {
    ClusterName = var.cluster_name
  }

  alarm_actions = [aws_autoscaling_policy.ecs_cluster_ram_high.arn]
}

resource "aws_cloudwatch_metric_alarm" "ecs_cluster_ram_low" {
  alarm_name          = "${var.cluster_name}_ram-reservation_low"
  comparison_operator = "LessThanThreshold"
  evaluation_periods  = var.ram_low_evaluation_periods
  metric_name         = "MemoryReservation"
  namespace           = "AWS/ECS"
  period              = var.ram_low_period
  statistic           = var.ram_low_statistic
  threshold           = var.ram_low_threshold

  dimensions = {
    ClusterName = var.cluster_name
  }
}

