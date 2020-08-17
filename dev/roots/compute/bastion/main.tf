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

provider "template" {
    version                 = "2.1"
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

data "template_file" "user_data" {
    template = file("../userdata/bastion/scripts/script.yaml")
}

data "aws_iam_instance_profile" "ec2-ssm-role" {
    name = "ec2-ssm-role"
}

module "bastion-asg"  {
  source                    = "terraform-aws-modules/autoscaling/aws"
  version                   = "~> 3.0"
  name                      = "${var.Environment}-${var.Role}"
//  name                      = "${var.Environment}-${var.Role}-${var.instance_count[index]}" //same name will pop up.
  lc_name                   = "${var.Environment}-${var.Role}-launch-configuration"
  image_id                  = var.bastion_ami
  instance_type             = var.instance_type
  security_groups           = data.aws_security_groups.bastion_security_group.ids
  vpc_zone_identifier       = data.aws_subnet_ids.private_subnet_groups.ids
  asg_name                  = "${var.Environment}-${var.Role}"
  key_name                  = var.key_name
  min_size                  = var.min_size
  max_size                  = var.max_size
  desired_capacity          = var.desired_capacity
  wait_for_capacity_timeout = 0                                # TBD
  health_check_type         = "EC2"
  iam_instance_profile      = data.aws_iam_instance_profile.ec2-ssm-role.name
  user_data                 = data.template_file.user_data.rendered


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
      value               = "development"
      propagate_at_launch = true
    },
    {
      key                 = "Role"
      value               = "bastion"
      propagate_at_launch = true
    },
  ]

//  tags_as_map = {
 //   docker-swarm-role = "manager"
//  }

}
