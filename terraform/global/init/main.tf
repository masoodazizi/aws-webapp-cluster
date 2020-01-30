locals {
  ssh_key_path = "./secrets/ecs-ssh-key"
}

resource "aws_s3_bucket" "terraform_state" {
  bucket = "myproject-terraform-remote-state"

  versioning {
    enabled = true
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
}

resource "aws_dynamodb_table" "terraform_locks" {
  name         = "myproject-terraform-state-locks"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}

resource "null_resource" "key_gen" {
  provisioner "local-exec" {
    command     = "ssh-keygen -b 2048 -t rsa -f '${local.ssh_key_path}' -q -N '' -C 'ECS instances key pair'"
    interpreter = ["/bin/bash", "-c"]
  }
}

data "local_file" "ssh_public_key" {
  filename = "${local.ssh_key_path}.pub"

  depends_on = [null_resource.key_gen]
}

output "ssh_key" {
  value = data.local_file.ssh_public_key.content
}

output "terraform_state_bucket" {
  value = aws_s3_bucket.terraform_state.id
}

