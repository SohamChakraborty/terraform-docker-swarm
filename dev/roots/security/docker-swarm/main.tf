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

data "aws_security_group" "ssh_bastion_security_group" {
  vpc_id = data.aws_vpc.selected.id
  tags = {
    Environment = "development"
    Role        = "bastion"
  }
}

module "docker_swarm_security_group" {
    source                        = "terraform-aws-modules/security-group/aws//modules/docker-swarm"
    version                       = "~> 3.0"
    name                          = "security-group-${var.environment}-${var.role}"
    use_name_prefix               = false
    description                   = "Security group for docker swarm service"
    vpc_id                        = data.aws_vpc.selected.id #TBD
//    ingress_cidr_blocks         = ["10.0.0.0/16"]
    ingress_cidr_blocks           = list(data.aws_vpc.selected.cidr_block)

    computed_ingress_with_source_security_group_id = [
      {
        rule                       = "ssh-tcp"
        source_security_group_id   = data.aws_security_group.ssh_bastion_security_group.id
      }
    ]
    number_of_computed_ingress_with_source_security_group_id = 1
    computed_egress_with_source_security_group_id = [
      {
        rule                      = "ssh-tcp"
        source_security_group_id  = data.aws_security_group.ssh_bastion_security_group.id
      }
    ]
    number_of_computed_egress_with_source_security_group_id = 1
    tags                        = {
                Environment     = var.environment
                Role            = var.role
    }
}

