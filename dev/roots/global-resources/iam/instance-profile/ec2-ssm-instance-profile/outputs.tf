output "ec2-ssm-role-arn" {
    description         = "ARN Of the EC2 SSM role"
    value               = module.ec2-ssm-role.this_iam_role_arn
}

output "ec2-ssm-role-name" {
    description         = "Name of the role"
    value               = module.ec2-ssm-role.this_iam_role_name
}

output "ec2-ssm-role-path" {
    description         = "Path of the role"
    value               = module.ec2-ssm-role.this_iam_role_path
}

