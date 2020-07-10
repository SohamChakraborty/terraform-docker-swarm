# variables for development environment

cidr            = "10.0.0.0/16"
azs             = ["eu-west-2a", "eu-west-2b", "eu-west-2c"]
environment     = "development"
role            = "main"
private_subnets = ["10.0.0.0/20", "10.0.16.0/20", "10.0.32.0/20"]
public_subnets  = ["10.0.64.0/20", "10.0.80.0/20", "10.0.96.0/20"]
purpose         = ""
