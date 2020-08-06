terraform {
  required_version  = "~> 0.12.13"
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

data "aws_security_groups" "mediawiki-security-group" {
    tags = {
        Role            = "mediawiki"
        Environment     = "development"
    }
}

data "aws_subnet" "mediawiki-subnet-id" {
    vpc_id              = data.aws_vpc.selected.id
    availability_zone   = var.azs
    tags = {
        Tier            = "public"
    }
}

data "aws_iam_instance_profile" "ec2-ssm-role" {
    name = "ec2-ssm-role"
}

resource "aws_instance" "mediawiki-instance" {
    ami                           = var.ami
    instance_type                 = var.instance_type
    availability_zone             = var.azs
    ebs_optimized                 = true
    key_name                      = var.key_name
    vpc_security_group_ids        = data.aws_security_groups.mediawiki-security-group.ids
    iam_instance_profile          = data.aws_iam_instance_profile.ec2-ssm-role.name
    subnet_id                     = data.aws_subnet.mediawiki-subnet-id.id
    root_block_device  {
            volume_type           = "gp2"
            volume_size           = var.ebs_volume_size
    }
    ebs_block_device {
            device_name           = "/dev/xvdz"
            volume_size           = var.root_volume_size
            volume_type           = "gp2"
            delete_on_termination = true
    }
    tags    = {
        environment             = var.environment
        role                    = var.role
        application             = var.application
    }









    provisioner "local-exec" {
    command = "echo ${aws_instance.mediawiki-instance.public_ip} > ip_address.txt"
  }
}