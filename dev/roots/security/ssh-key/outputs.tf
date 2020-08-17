output "docker-ssh-key-name" {
    description                 = "Name of the key pair"
    value                       = aws_key_pair.docker_ssh_key.id
}

output "docker-ssh-key-id" {
    description                 = "ID of the key pair"
    value                       = aws_key_pair.docker_ssh_key.key_pair_id
}
