##############################
# ECS Cluster: IAM           #
##############################

resource "aws_iam_instance_profile" "ecs_instance_profile" {
  name = "ecs-instance-role"
  path = "/"
  role = aws_iam_role.ecs_instance_role.name
}

resource "aws_iam_role" "ecs_instance_role" {
  name = "ecs-instance-role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF

}

resource "aws_iam_policy_attachment" "ecs_instance_role_attach_ecs_for_ec2" {
  name       = "ecs-instance-role-attach-ecs-for-ec2"
  roles      = [aws_iam_role.ecs_instance_role.id]
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceforEC2Role"
}

resource "aws_iam_policy" "ecs_cloudwatch_logs_policy" {
  name        = "CloudWatchLogsECSAccess"
  path        = "/"
  description = "Allow ECS to create log groups and write logs"

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "logs:CreateLogGroup",
                "logs:CreateLogStream",
                "logs:PutLogEvents",
                "logs:DescribeLogStreams"
            ],
            "Resource": [
                "arn:aws:logs:*:*:*"
            ]
        }
    ]
}
EOF

}

resource "aws_iam_policy_attachment" "ecs_instance_role_attach_cloudwatch_logs" {
  name       = "ecs-instance-role-attach-cloudwatch-logs"
  roles      = [aws_iam_role.ecs_instance_role.id]
  policy_arn = aws_iam_policy.ecs_cloudwatch_logs_policy.arn
}

##############################
# ECS Service: IAM           #
##############################

resource "aws_iam_role" "ecs_service_role" {
  name = "ecsServiceRole"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
        "Service": "ecs.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF

}

resource "aws_iam_policy_attachment" "ecs_service_role_attach_ecs_service" {
  name       = "ecs-service-role-attach"
  roles      = [aws_iam_role.ecs_service_role.id]
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceRole"
}

resource "aws_iam_role" "ecs_service_autoscale_role" {
  name = "ecsServiceAutoscaleRole"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
        "Service": "application-autoscaling.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF

}

resource "aws_iam_policy_attachment" "ecs_service_autoscale_role" {
  name       = "ecs-service-role-attach-autoscale"
  roles      = [aws_iam_role.ecs_service_autoscale_role.id]
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceAutoscaleRole"
}
