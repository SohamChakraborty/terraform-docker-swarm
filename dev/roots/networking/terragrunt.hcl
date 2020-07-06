include {
  path = find_in_parent_folders()
}

terraform {
  extra_arguments "networking_vars" {
    commands = [
      "apply",
      "plan",
      "import",
      "push",
      "refresh",
      "destroy"
    ]
    required_var_files = [
      "${get_parent_terragrunt_dir()}/variables/networking/development.tfvars"
    ]
    #arguments = [
    #  "--var-file=${get_parent_terragrunt_dir()}/variables/networking/development.tfvars"
    #]
  }
}
