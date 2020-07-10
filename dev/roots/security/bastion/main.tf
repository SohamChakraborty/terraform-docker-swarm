terraform {
  required_version  = ">=0.12.13"
  backend "s3" {}
}

provider "aws" {
    region                  = "eu-west-2"
    shared_credentials_file = "/home/soham/.aws/credentials"
    profile                 = "soham-pythian-sandbox"
}

data "aws_vpc" "selected" {
  filter {
    name = "tag:Environment"
    values = ["development"]
  }
}

module "ssh_bastion_security_group" {
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

output "aws_vpc_id" {
    value = data.aws_vpc.selected.id
}

output "ssh_bastion_security_group_id" {
    description = "ID of the bastion host security group"
    value       = module.ssh_bastion_security_group.this_security_group_id
}

output "ssh_bastion_security_group_name" {
    description = "Name of the bastion host security group"
    value       = module.ssh_bastion_security_group.this_security_group_name
}