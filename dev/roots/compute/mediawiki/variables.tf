variable "instance_type" {
    description             = "Type of the instance used to create mediawiki"
}

variable "ami" {
    description             = "Image ID"
}

variable "key_name" {
    description             = "Name of the SSH key pair to login"
}

variable "ebs_volume_size" {
    description             = "Size of the EBS volume"
}

variable "root_volume_size" {
    description             = "Size of the root volume size"
}

variable "environment"      {
    description             = "Name of the environment"
}

variable "role"             {
    description             = "Role of the EC2 instance"
}

variable "application"      {
    description             = "Name of the application"
}

variable "azs"              {
    description             = "Availability zones where this instance may run"
}

//variable "iam_instance_profile" {
//    description             = "IAM instance profile for the instance"
//}