include {
  path = find_in_parent_folders()
}

terraform {
  extra_arguments "docker_swarm_manager_vars" {
    commands = [
      "apply",
      "plan",
      "import",
      "push",
      "refresh",
      "destroy"
    ]
    required_var_files = [
      "${get_parent_terragrunt_dir()}/variables/compute/docker-swarm-worker/development.tfvars"
    ]
  }
}
