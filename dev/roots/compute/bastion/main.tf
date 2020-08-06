//terraform {
#  required_version  = ">=0.12.13"
#  backend "s3" {}
#
#}
#
#provider "aws" {
#    region                  = "eu-west-2"
#    shared_credentials_file = "/home/soham/.aws/credentials"
#    profile                 = "soham-pythian-sandbox"
#    version                 = "2.69"
#}
#
#provider "template" {
#    version        = "2.1.2"
#}
#
#data "aws_vpc" "selected" {
#  filter {
#    name = "tag:Environment"
#    values = ["development"]
#  }
#}
#
#data "aws_subnet_ids" "private_subnets" {
#    vpc_id = data.aws_vpc.selected.id
#    filter {
#      name    = "tag:Name"
#      values  = ["development-primary-vpc-private-*"]
#    }
#}
#
#data "aws_subnet" "public_subnet" {
#    vpc_id = data.aws_vpc.selected.id
#    filter {
#      name    = "tag:Name"
#      values  = ["development-primary-vpc-public-eu-west-2a*"]
#    }
#}
#
#data "aws_route_tables" "private_route_tables" {
#  vpc_id      = data.aws_vpc.selected.id
#  filter {
#    name      = "tag:Name"
#    values    = ["development-primary-vpc-private-*"]
#  }
#}
#
#// As of now, the user data cannot be rendered because the following module doesn't use it.
#// Maybe I will refactor it at some time.
#
#data "template_file" "user_data" {
#  template               = "${file("${path.module}/bastion-user-data.conf.tmpl")}"
#}
#
#module "nat" {
#  source                      = "int128/nat-instance/aws"
#  version                     = "1.0.2"
#  name                        = "main"
#  key_name                    = var.key_name              // Key has been added with terraform
#  vpc_id                      = data.aws_vpc.selected.id
#  public_subnet               = data.aws_subnet.public_subnet.id
#  private_subnets_cidr_blocks = list(data.aws_vpc.selected.cidr_block)
#//  private_subnets_cidr_blocks = data.aws_subnet_ids.private_subnets.
#  private_route_table_ids     = data.aws_route_tables.private_route_tables.ids
#}

# This is to see how we can provision bastion hosts separately with autoscaling groups
# Also the previous module couldn't let us use the security groups defined from our directory structure

terraform {
  required_version  = "~> 0.12.13"
  backend "s3" {}

}

provider "aws" {
    region                  = "eu-west-2"
    shared_credentials_file = "/home/soham/.aws/credentials"
    profile                 = "soham-pythian-sandbox"
}

data "aws_ami" "bastion_ami" {
  most_recent      = true
  owners           = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn-ami-hvm-????.??.?.????????-x86_64-gp2"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

data "aws_vpc" "selected" {
  filter {
    name = "tag:Environment"
    values = ["development"]
  }
}

data "aws_subnet_ids" "private_subnet_groups" {
  vpc_id = data.aws_vpc.selected.id
 
  tags = {
    Tier  = "public"
  }
}

data "aws_security_groups" "bastion_security_group" {
  tags      = {
    Role    = "bastion"
  }
}

module "bastion-asg" {
  source                    = "terraform-aws-modules/autoscaling/aws"
  version                   = "~> 3.0"
  name                      = "${var.environment}-${var.role}"
//  name                      = "${var.environment}-${var.role}-${var.instance_count[index]}" //same name will pop up.
  lc_name                   = "${var.environment}-${var.role}-launch-configuration"
  image_id                  = data.aws_ami.bastion_ami.image_id
  instance_type             = var.instance_type
  security_groups           = data.aws_security_groups.bastion_security_group.ids
  vpc_zone_identifier       = data.aws_subnet_ids.private_subnet_groups.ids
  asg_name                  = "${var.environment}-${var.role}"
  key_name                  = var.key_name
  min_size                  = var.min_size
  max_size                  = var.max_size
  desired_capacity          = var.desired_capacity
  wait_for_capacity_timeout = 0                                # TBD
  health_check_type         = "EC2"


  ebs_block_device = [
    {
      device_name           = "/dev/xvdz"
      volume_type           = "gp2"
      volume_size           = var.ebs_volume_size
      delete_on_termination = true
    },
  ]

  root_block_device = [
    {
      volume_size           = var.root_volume_size
      volume_type           = "gp2"
    }
  ]

  tags = [
    {
      key                 = "Environment"
      value               = "var.environment"
      propagate_at_launch = true
    },
    {
      key                 = "Role"
      value               = "var.role"
      propagate_at_launch = true
    },
  ]

//  tags_as_map = {
 //   docker-swarm-role = "manager"
//  }
}
