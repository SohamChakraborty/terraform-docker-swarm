include {
  path = find_in_parent_folders()
}

terraform {
  extra_arguments "iam_vars" {
    commands = [
      "apply",
      "plan",
      "import",
      "push",
      "refresh",
      "destroy"
    ]
    required_var_files = [
      "${get_parent_terragrunt_dir()}/variables/iam/instance-profile/ec2-ssm-instance-profile/development.tfvars"
    ]
  }
}

