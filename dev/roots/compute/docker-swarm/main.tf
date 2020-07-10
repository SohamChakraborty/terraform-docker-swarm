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

data "aws_subnet_ids" "all" {
  vpc_id = data.aws_vpc.selected.id
}

//data "aws_security_groups" "sg" {
//  filter {
//    name = ""
//  }
//}

//module "docker-swarm-manager-asg" {
//  source                    = "terraform-aws-modules/autoscaling/aws"
//  version                   = "~> 3.0"
//  name                      = "docker-swarm-manager"
//  lc_name                   = "docker-swarm-manager-launch-configuration"
//  image_id                  = var.image_id
//  instance_type             = var.instance_type
//  security_groups           = var.security_groups

//  ebs_block_device = [
//    {
//      device_name           = "/dev/xvdz"
//      volume_type           = "gp2"
//      volume_size           = var.ebs_volume_size
//      delete_on_termination = true
//    },
//  ]

//  root_block_device = [
//    {
//      volume_size           = var.root_volume_size
//      volume_type           = "gp2"
//    }
//  ]

//  asg_name                  = "${var.environment}-${var.role}"
//  vpc_zone_identifier       = "var.vpc_zone_identifier"       # TBD
//  min_size                  = var.min_size
//  max_size                  = var.max_size
//  desired_capacity          = var.desired_capacity
//  wait_for_capacity_timeout = 0                                # TBD
//}

//module "nlb" {
//  source                    = "terraform-aws-modules/alb/aws"
//  version                   = "~5.0"

//  name                      = "${var.environment}-{var.role}-nlb"
//  load_balancer_type        = var.load_balancer_type
//  vpc_id                    = data.aws_vpc.default.id
//  subnets                   = data.vpc.private_subnet
//}
