
variable "environment" {
  type        = string
  description = "The name of the environment we'd like to launch."
}

variable "repository_url" {
  type        = string
  description = "The url of the ECR repository we'll draw our images from."
}

variable "image_version" {
  type = string
  description = "Image version"
}

variable "dynamodb_table_name" {
  type = string
}

variable "dynamodb_table_arn" {
  type = string
  description = "The name of dynamodb table"
}

variable "aws_region" {
  type        = string
  description = "The name of the AWS Region we'll launch into."
  default     = "us-east-1"
}

variable "launch_type" {
  type = string
  description = "Launch type"
  default = "FARGATE"
}

variable "platform_version" {
  type = string
  default = "latest"
}

variable "fargate_cpu" {
  type    = number
  default = 2048
}

variable "memory" {
  type    = number
  default = 4096
  description = "Memory of the instance"
}

variable "desired_count" {
  type    = number
  default = 1
  description = "Count of the instances"
}

variable "task_count" {
  type    = number
  default = 1
  description = "The count of the task"
}

variable "public_subnets" {
  type = list(string)
  description = "The IDs of public subnets"
}

variable "vpc_id" {
  type = string
  description = "The ID of VPC"
}

variable "network_mode" {
  type = string
  default = "awsvpc"
  description = "Type of the network mode"
}

variable "schedule_expression" {
  type = string
  default = "rate(7 days)"
  description = "CRON express to schedule the task"
}

variable "retention_in_days" {
  type = number
  default = 90
  description = "The log retention in days"
}

variable "requires_compatibilities" {
  type = list(string)
  default = ["FARGATE"]
  description = "Type of compatibilities"
}