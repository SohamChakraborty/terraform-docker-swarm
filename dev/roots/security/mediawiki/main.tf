terraform {
  required_version  = ">=0.12.13"
  backend "s3" {}
}

provider "aws" {
    region                  = "eu-west-2"
    shared_credentials_file = "/home/soham/.aws/credentials"
    profile                 = "soham-pythian-sandbox"
    version                 = "2.69"
}

data "aws_vpc" "selected" {
  filter {
    name = "tag:Environment"
    values = ["development"]
  }
}

module "mediawiki_security_group" {
    source                      = "terraform-aws-modules/security-group/aws//modules/ssh"
    version                     = "~> 3.0"
    name                        = "security-group-${var.environment}-${var.role}"
    description                 = "Security group for bastion host"
    vpc_id                      = data.aws_vpc.selected.id #TBD
    ingress_cidr_blocks         = ["0.0.0.0/0"]
    tags                        = {
                Environment     = var.environment
                Role            = var.role
    }
}

