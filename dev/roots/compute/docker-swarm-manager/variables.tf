//variable "image_id" {
//    description     = "AMI from which the docker swarm cluster is built"
//}

variable "instance_type" {
    description     = "What is the instance type to build docker swarm cluster"
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
    description     = "Minimum size of the development docker swarm cluster"
}

variable "max_size" {
    description     = "Maximum size of the development docker swarm cluster"
}

variable "desired_capacity" {
    description     = "Desired capacity of the development docker swarm cluster"
}

//variable "custom_tags" {
//  description = "Custom tags to set on the Instances in the ASG"
//  type        = map(string)
//}

variable "instance_count" {
    description = "Let's see"
    type        = list(number)
}

variable "key_name" {
    description = "SSH key to access"
}
