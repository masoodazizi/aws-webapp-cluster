resource "aws_s3_bucket" "alb_access_logs" {
  bucket = "${var.project}-alb-access-logs"

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }

  #   policy = <<EOF
  #   {
  #     "Version": "2012-10-17",
  #     "Statement": [
  #       {
  #         "Effect": "Allow",
  #         "Principal": {
  #           "AWS": "arn:aws:iam::${var.aws_account_id}:root"
  #         },
  #         "Action": "s3:PutObject",
  #         "Resource": "arn:aws:s3:::${var.project}-alb-access-logs/*"
  #       }
  #     ]
  #   }
  # EOF

  tags = "${merge(local.tags, map("Name", "alb_access_logs_bucket"))}"
}
