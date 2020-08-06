resource "null_resource" "ansible-provision" {
  depends_on = ["module.bastion-asg"]

  provisioner "local-exec" {
  command = "echo \"[swarm-manager]\" > swarm-inventory"
  }
}