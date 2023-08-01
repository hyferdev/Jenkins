variable "aws_region" {
  description = "regions my resources will be deployed"
  type        = string
  default     = "us-west-2"
}

variable "instance_type" {
  type    = string
  default = "t2.micro"
}

variable "ami" {
  type    = string
  default = "ami-00970f57473724c10"
}

variable "keys" {
  type    = string
  default = "RedKeys"
}

variable "s3bucket" {
  type    = string
  default = "hyfer-bucket"
}
