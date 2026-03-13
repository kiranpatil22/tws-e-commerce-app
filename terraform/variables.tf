variable "aws_region" {
  description = "AWS region where resources will be provisioned"
  type        = string
  default     = "us-west-2"
}

variable "ami_id" {
  description = "AMI ID used for launching the EC2 instance"
  type        = string
  default     = "ami-085f9c64a9b75eed5"
}

variable "instance_type" {
  description = "EC2 instance type for compute resources"
  type        = string
  default     = "c7i-flex.large"
}

variable "my_environment" {
  description = "Deployment environment (dev, stage, prod)"
  type        = string
  default     = "dev"
}
