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

resource "aws_key_pair" "docker_ssh_key" {
    key_name                = "docker_ssh_key"
    tags                    = {
        Name           = "docker-ssh-key"
  }
    public_key              = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDACWKULsfI5Hyk8j7IIZfH27aphiipTvzA6Q+MBZKYSMbvQu5B7ZYHA/++wlxbViF6guc6WgdJra9vb6JKmWD6MliiaDJ+eEL/WQKgmC2BTk5d6f2LRw6UtSyIr9QSzeNYeu2nMR1UgR/RT2Qw30UEtMcyE24OYm2y1E40C6okQT63jDfasrpxUk9BgRr23x6UQCVBuTdyBNOCuSOXfDgY69RhPAnlHtoRwcnjiskjG+nRMX+PDna9ZyANhfEYIUHhmumDLYP9wqkQ3kYMZTqhvioq/WND+a6SnZDpBWgKAyIsCFx72tDfBr6T/gINZi0uxyme1s9l0MJ1BOG+pPZOYH5YMJvNq7T9i8wUGhW+RZZETXWAqR5H9NjqTrwB5+RrXl2dwc2b9A4msthuP3b7bU42a2uWPmLkl1GYdMUGZf2anFP3Iku32y0mj2GZZz5ahYG7d8TpYpvrm+jYa3sw3Oa6jyaR3SSr0yC0opLV5VuHndAqrlLEfjdhIUy87bM= soham@localhost.localdomain"
}

