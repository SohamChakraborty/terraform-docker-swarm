terraform {
  required_version  = ">=0.12.13"
  backend "s3" {}
}

provider "aws" {
    region                  = "eu-west-2"
    shared_credentials_file = "/home/soham/.aws/credentials"
    profile                 = "soham-pythian-sandbox"
}

//module "iam_assumable_roles" {
//  source  = "terraform-aws-modules/iam/aws//modules/iam-assumable-role"
//  version = "~> 2.0"

  //trusted_role_services = [
    //"ec2.amazonaws.com"
 // ]
//  poweruser_role_name        = "ec2-ssm-role"
//  poweruser_role_policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
 // create_instance_profile   = true
 // create_role               = true
 // role_name                 = "ec2-ssm-role"
//  trusted_role_arns         = ["arn:aws:iam::769886337291:root"]
//}

module "iam_assumable_role" {
  source                      = "terraform-aws-modules/iam/aws//modules/iam-assumable-role"
  version                     = "~> 2.0"

  create_role                 = true
  role_name                   = "ec2-ssm-role"
  role_requires_mfa           = false
//  trusted_role_arns = [
//    "arn:aws:iam::769886337291:ec2",
//      ]
  trusted_role_services       = ["ec2.amazonaws.com"]
  create_instance_profile     = true
  custom_role_policy_arns     = ["arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"]
}