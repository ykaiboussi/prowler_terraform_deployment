# network module creates one VPC with 2 public subnets
module "network" {
  source      = "../modules/network"

  environment = var.environment
}

# A DynamoDB stream invokes an AWS Lambda function.
# The Lambda function maps Prowler findings into the AWS Security Finding Format (ASFF) before importing them to Security Hub.
module "etl" {
  source        = "../modules/etl"
  
  account_num   = var.account_number
  region        = var.aws_region
}

# A time-based CloudWatch Event starts the Fargate task on a predefined schedule (default every 7 days.)
# Task scans your AWS infrastructure and writes the scan results to a CSV file.
# Python scripts in the Prowler container convert the CSV to JSON and load an Amazon DynamoDB table with formatted Prowler findings.
module "ecs_cluster" {
  source         = "../modules/ecs_cluster"
  
  environment    = var.environment

  repository_url = var.repository_url
  image_version  = var.image_version

  dynamodb_table_name = module.etl.dynamodb_table_name
  dynamodb_table_arn  = module.etl.dynamodb_table_arn

  vpc_id         = module.network.vpc_id
  public_subnets = module.network.public_subnets
}