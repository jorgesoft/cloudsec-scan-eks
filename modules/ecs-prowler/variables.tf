variable "subnets" {
  description = "A list of subnet IDs to use for the Prowler cluster"
  type        = list(string)
}

variable "cluster_id" {
  description = "The ID of the ECS service"
  type        = string
}

variable "prowler_services" {
  description = "List of AWS services to scan with Prowler"
  type        = string
}

variable "bucket_name" {
  description = "Name of the S3 bucket to store reports"
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