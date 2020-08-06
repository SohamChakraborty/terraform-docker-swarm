output "aws_vpc_id" {
    value = data.aws_vpc.selected.id
}

output "mediawiki_security_group_id" {
    description = "ID of the mediawiki host security group"
    value       = module.mediawiki_security_group.this_security_group_id
}

output "mediawiki_security_group_name" {
    description = "Name of the mediawiki host security group"
    value       = module.mediawiki_security_group.this_security_group_name
}
