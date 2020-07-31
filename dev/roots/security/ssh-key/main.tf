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

resource "aws_key_pair" "soham_ssh_key" {
    key_name                = "soham-ssh-key-eu-west-2"
    tags                    = {
        name           = "soham-ssh-key"
  }
    public_key              = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDH8uZQzBu7yZs+Bi8khqCk4lo88sJAnMr0BkujNnYOxk+Ov/WxrIy1YllB5d6S9TNfi7vVjMoufq+kO1OcXAeKEPcsNQy11DQOaEhd5UD+jWwSuJTsGgdamn7hlUfbxcDO+l3w15x0jZ2ZvS4MUdRHNblcIdViESvgTK9RdY1UGJkm7v9+Ns1rDimckH6sCca5Zqund79acO8oopEEtePKxzKgwFFg7p65OFKmw/AMMbPqzP7WUc1tZJ788+cHSFjHF9hDsR4ykucU1ngbVdPGBL0igLgr5eG2D0xHLUOsGPpZIdyOaHyu+7YURgRcR4Vuq5m7FBtRE064vO8Vww0LWCNkeJHpymx1OZV+1L2eTkFAjiwccPcbAgOuX2waVbBHC1cqu9nJmV+VXsJXc17OxrKo9k8bzjFAMBCv8Lj13q0Pon/oNY8lhwISVVlmZw3l0a8Bg4Jt49Wag9HbZOqWpO0tHjzBi0DNUOFaJcpyzJRWa9gpxBzYdOFOZzcigPs= soham@localhost.localdomai"
}