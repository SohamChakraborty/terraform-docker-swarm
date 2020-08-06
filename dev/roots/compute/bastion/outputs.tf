#output "eip_id" {
#    description = "ID Of the EIP"
#    value       = module.nat.eip_id
#}
#
#output "eip_public_ip" {
#    description = "Public EIP"
#    value       = module.nat.eip_public_ip
#}
#
#output "eni_private_ip" {
#    description = "Private ENI IP"
#    value       = module.nat.eni_private_ip
#}

output "asg_az" {
    description     = "AZ of the ASG"
    value           = module.bastion-asg.this_autoscaling_group_availability_zones
}

output "asg_name" {
    description     = "Name of the ASG"
    value           = module.bastion-asg.this_autoscaling_group_name
}