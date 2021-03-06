variable "docker_swarm_ami" {
    description     = "AMI from which the docker swarm workers are built"
}

variable "instance_type" {
    description     = "What is the instance type to build docker swarm worker cluster"
}

variable "ebs_volume_size" {
    description     = "Size of the EBS volume"
}

variable "root_volume_size" {
    description     = "Size of the root volume"
}

variable "environment" {
    description     = "Environment name"
}

variable "role" {
    description     = "Role name"
}

variable "min_size" {
    description     = "Minimum size of the development docker swarm worker cluster"
}

variable "max_size" {
    description     = "Maximum size of the development docker swarm worker cluster"
}

variable "desired_capacity" {
    description     = "Desired capacity of the development docker swarm worker cluster"
}

variable "key_name" {
    description     = "SSH key to access"
}
