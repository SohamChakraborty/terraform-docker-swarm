provider "aws" {
  region   = "eu-west-2"
  profile  = "soham-pythian-sandbox"
}

resource "aws_s3_bucket" "terraform_state" {
  bucket = "docker-swarm-state"

  lifecycle {
   # prevent_destroy = true
    prevent_destroy = false
  }

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