output "aws_vpc_id" {
    value = data.aws_vpc.selected.id
}

output "docker_swarm_sg_id" {
    description = "ID of the docker swarm security group"
    value       = module.docker_swarm_security_group.this_security_group_id
}

output "docker_swarm_sg_name" {
    description = "Name of the docker swarm security group"
    value       = module.docker_swarm_security_group.this_security_group_name
}