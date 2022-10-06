module "network" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "3.14.4"

  name = "prowler-app-${var.environment}-main_vpc"
  cidr = var.cidr

  azs            = var.azs
  public_subnets = var.public_subnets

  enable_dns_hostnames = true
  enable_dns_support   = true
}