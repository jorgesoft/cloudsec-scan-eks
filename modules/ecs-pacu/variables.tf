variable "subnets" {
  description = "A list of subnet IDs to use for the Pacu container"
  type        = list(string)
}

variable "cluster_id" {
  description = "The ID of the ECS cluster"
  type        = string
}

variable "bucket_name" {
  description = "Name of the S3 bucket to store reports"
  type        = string
}

variable "ssh_password" {
  description = "Secure SSH password"
}

variable "vpc_id" {
  description = "The id for the VPC"
  type        = string
}

variable "log_group_arn" {
  description = "The ARN of the CloudWatch Log Group"
  type        = string
}

variable "log_group_name" {
  description = "The name of the CloudWatch Log Group"
  type        = string
}