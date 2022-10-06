output "vpc_id" {
  value       = module.network.vpc_id
  description = "ID of the VPC"
}

output "public_subnets" {
  value = module.network.public_subnets
  description = "The IDs of public subnet"
}