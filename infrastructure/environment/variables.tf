variable "aws_profile" {
  type        = string
  description = "The name of the AWS credentials profile we will use."
}

variable "aws_region" {
  type        = string
  description = "The name of the AWS Region we'll launch into."
}

variable "repository_url" {
  type        = string
  description = "The url of the ECR repository we'll draw our images from."
}

variable "image_version" {
  type       = string
  description = "Image version"
}

variable "account_number" {
  type = string
  description = "AWS account number"
}

variable "environment" {
  type = string
  description = "Name of the environment"
}