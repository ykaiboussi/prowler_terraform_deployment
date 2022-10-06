variable "account_num" {
  type = string
}

variable "region" {
  type = string
}

variable "stream_enabled" {
  type    = bool
  default = true
}

variable "stream_view_type" {
  type = string
  default = "NEW_IMAGE"
}

variable "read_capacity" {
  type    = number
  default = 50
}

variable "write_capacity" {
  type    = number
  default = 50
}

variable "function_name" {
  type = string
  description = "Name of the function"
  default = "prowler-to-securityhub-lambda-function"
}

variable "handler" {
  type = string
  default = "index.lambda_handler"
}

variable "memory_size" {
  type    = number
  default = 384
  description = "The size of momery"
}

variable "runtime" {
  type    = string
  default = "python3.7"
  description = "The type of lambda's runtime"
}