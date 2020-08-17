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

module "ec2-ssm-role" {
  source                      = "terraform-aws-modules/iam/aws//modules/iam-assumable-role"
  version                     = "~> 2.0"

  create_role                 = true
  role_name                   = "ec2-ssm-role"
  role_requires_mfa           = false
  trusted_role_services       = ["ec2.amazonaws.com"]
  create_instance_profile     = true
  custom_role_policy_arns     = ["arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"]
}

