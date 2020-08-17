variable "bastion_ami" {
    description         = "Image ID of the bastion host"
}

variable "key_name" {
    description         = "SSH Key to login to the bastion server"
}

variable "instance_type" {
    description     = "What is the instance type to build bastion server"
}

variable "ebs_volume_size" {
    description     = "Size of the EBS volume"
}

variable "root_volume_size" {
    description     = "Size of the root volume"
}

variable "Environment" {
    description     = "Environment name"
}

variable "Role" {
    description     = "Role name"
}

variable "min_size" {
    description     = "Minimum size of the development bastion host"
}

variable "max_size" {
    description     = "Maximum size of the development bastion host"
}

variable "desired_capacity" {
    description     = "Desired capacity of the development bastion host"
}

variable "instance_count" {
    description = "Let's see"
    type        = list(number)
}
