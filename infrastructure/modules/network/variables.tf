variable "environment" {
  type        = string
  description = "The name of the environment we'd like to launch."
}

variable "cidr" {
  type    = string
  default = "172.0.0.0/16"
}

variable "azs" {
  type = list(string)
  default = ["us-east-1a", "us-east-1c"]
}

variable "public_subnets" {
  type = list(string)
  default = ["172.0.3.0/24", "172.0.4.0/24"]
}