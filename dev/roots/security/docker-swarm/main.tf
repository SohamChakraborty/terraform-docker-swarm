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

module "docker_swarm_security_group" {
    source                      = "terraform-aws-modules/security-group/aws//modules/docker-swarm"
    version                     = "~> 3.0"
    name                        = "security-group-${var.environment}-${var.role}"
    use_name_prefix             = false
    description                 = "Security group for docker swarm service"
    vpc_id                      = data.aws_vpc.selected.id #TBD
//    ingress_cidr_blocks         = ["10.0.0.0/16"]
    ingress_cidr_blocks         = list(data.aws_vpc.selected.cidr_block)
    tags                        = {
                Environment     = var.environment
                Role            = var.role
    }
}

output "aws_vpc_id" {
    value = data.aws_vpc.selected.id
}

output "docker_swarm_sg_id" {
    description = "ID of the docker swarm security group"
    value       = module.docker_swarm_security_group.this_security_group_id
}

output "docker_swarm_sg_name" {
    description = "Name of the docker swarm security group"
    value       = module.docker_swarm_security_group.this_security_group_name
}