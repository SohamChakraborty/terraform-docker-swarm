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

provider "template" {
    version        = "2.1.2"
}

data "aws_vpc" "selected" {
  filter {
    name = "tag:Environment"
    values = ["development"]
  }
}

data "aws_subnet_ids" "private_subnets" {
    vpc_id = data.aws_vpc.selected.id
    filter {
      name    = "tag:Name"
      values  = ["development-primary-vpc-private-*"]
    }
}

data "aws_subnet" "public_subnet" {
    vpc_id = data.aws_vpc.selected.id
    filter {
      name    = "tag:Name"
      values  = ["development-primary-vpc-public-eu-west-2a*"]
    }
}

data "aws_route_tables" "private_route_tables" {
  vpc_id      = data.aws_vpc.selected.id
  filter {
    name      = "tag:Name"
    values    = ["development-primary-vpc-private-*"]
  }
}

// As of now, the user data cannot be rendered because the following module doesn't use it.
// Maybe I will refactor it at some time.

data "template_file" "user_data" {
  template               = "${file("${path.module}/bastion-user-data.conf.tmpl")}"
}

module "nat" {
  source                      = "int128/nat-instance/aws"
  version                     = "1.0.2"
  name                        = "main"
  key_name                    = var.key_name            // Key has been added with terraform
  vpc_id                      = data.aws_vpc.selected.id
  public_subnet               = data.aws_subnet.public_subnet.id
  private_subnets_cidr_blocks = list(data.aws_vpc.selected.cidr_block)
//  private_subnets_cidr_blocks = data.aws_subnet_ids.private_subnets.
  private_route_table_ids     = data.aws_route_tables.private_route_tables.ids
}
