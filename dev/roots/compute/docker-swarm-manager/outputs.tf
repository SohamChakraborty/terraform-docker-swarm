output "docker-swarm-manager-asg-name" {
    description = "Name of the docker swarm manager ASG"
    value       = module.docker-swarm-manager-asg.this_autoscaling_group_name
}

output "docker-swarm-manager-lc-name" {
    description = "Name of the launch configuration"
    value       = module.docker-swarm-manager-asg.this_launch_configuration_name
}

output "docker-swarm-manager-lc-id" {
    description = "Name of the launch configuration"
    value       = module.docker-swarm-manager-asg.this_launch_configuration_id
}

output "docker-swarm-manager-asg-id" {
    description = "ID of the docker swarm manager ASG"
    value       = module.docker-swarm-manager-asg.this_autoscaling_group_id
}

output "docker-swarm-manager-subnets" {
    description = "VPC ID of the VPC where this ASG resides"
    value       = module.docker-swarm-manager-asg.this_autoscaling_group_vpc_zone_identifier
}