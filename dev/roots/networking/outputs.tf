output "vpc_id" {
  description = "The ID of the VPC"
  value       = module.vpc.vpc_id
}

output "vpc_cidr_block" {
  description   = "The CIDR block of VPC"
  value         = module.vpc.vpc_cidr_block
}

output "private_subnets" {
  description   = "List of IDs of private subnets"
  value         = module.vpc.private_subnets
}

output "public_subnets" {
  description   = "List of IDs of public subnets"
  value         = module.vpc.public_subnets
}

output "azs" {
  description   = "A list of availability zones specified as argument to this module"
  value         = module.vpc.azs  
}

output "private_route_table_ids" {
  description = "A list of private route table ids"
  value       = module.vpc.private_route_table_ids
}

output "private_subnets_cidr_blocks" {
  description = "A list of private subnet CIDR block"
  value       = module.vpc.private_subnets_cidr_blocks
}

output "public_subnets_cidr_blocks" {
  description = "A list of public subnet CIDR block"
  value       = module.vpc.public_subnets_cidr_blocks
}