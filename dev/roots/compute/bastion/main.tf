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

data "aws_subnet_ids" "private_subnets" {
    vpc_id = data.aws_vpc.selected.id
    filter {
      name    = "tag:Name"
      values  = ["development-primary-vpc-private-*"]
    }
}

//data "aws_subnet_ids" "public_subnets" {
//    vpc_id = data.aws_vpc.selected.id
//    filter {
//      name    = "tag:Name"
//      values  = ["development-primary-vpc-public-*"]
//    }
//}

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

module "nat" {
  source                      = "int128/nat-instance/aws"

  name                        = "main"
  vpc_id                      = data.aws_vpc.selected.id
  public_subnet               = data.aws_subnet.public_subnet.id
  private_subnets_cidr_blocks = list(data.aws_vpc.selected.cidr_block)
//  private_subnets_cidr_blocks = data.aws_subnet_ids.private_subnets.
  private_route_table_ids     = data.aws_route_tables.private_route_tables.ids
}
