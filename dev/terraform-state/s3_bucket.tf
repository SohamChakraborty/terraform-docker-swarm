provider "aws" {
  region   = "eu-west-2"
  profile  = "soham-pythian-sandbox"
}

resource "aws_s3_bucket" "terraform_state" {
  bucket = "docker-swarm-state"

// We have prevent_destroy = false here because we may need to remove the terraform state until 
// the infrastructure is finalized.

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