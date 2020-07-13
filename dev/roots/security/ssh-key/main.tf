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
    public_key              = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDLubLnkS0lxmcj7AWQjUdflJmG9j+GcKIgteX2jgnCcljiNTd2RG3RXwrg1d/aumbknrkl02W2pfsZ7fxy14Qw+1kInefUb5/Eu0DBRYDOamYuzDvF0igQdHvFaZ067FeZgNNU/UBBAAT6Pr4JrNnx59HofTbB/W/+swdbs5lXJkgMqlgqAJk1pTicRVdegscQrJVkl/uxKRSmuY/mNHZoCh7ApIQcCoWrs2Mv/J39Os+gAb1UIWL0E48Exq6opXxRWZFi/636TmamFjzRzAoZqS4lbGOs2Ejo6Lt8WNq0DphREQXQSTauYDT/A6lIaBfzWFDSpW99lCFNdE4N5QbC7FRgtkrQSTp2zSkz2OQ9Wp/hddvkkzAF9K4aovxNYHKMc2e0Hon+jFm5KdTsnk7BWOM1siWL0cS2ttByK99eriMFQYV7zw/V6nFK58SkeL4BYd8PWiaFP/5iwXpnk/PH2PSpLRq7dXey1Qs0MYmN2ihN/vyT+lT9OCc5KtJl1H8= soham@localhost.localdomain"
}