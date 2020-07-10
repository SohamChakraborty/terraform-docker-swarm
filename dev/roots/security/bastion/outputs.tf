output "aws_vpc_id" {
    value = data.aws_vpc.selected.id
}

output "ssh_bastion_security_group_id" {
    description = "ID of the bastion host security group"
    value       = module.ssh_bastion_security_group.this_security_group_id
}

output "ssh_bastion_security_group_name" {
    description = "Name of the bastion host security group"
    value       = module.ssh_bastion_security_group.this_security_group_name
}