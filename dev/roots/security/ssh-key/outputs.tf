output "soham-ssh-key-name" {
    description                 = "Name of the key pair"
    value                       = aws_key_pair.soham_ssh_key.id
}

output "soham-ssh-key-id" {
    description                 = "ID of the key pair"
    value                       = aws_key_pair.soham_ssh_key.key_pair_id
}