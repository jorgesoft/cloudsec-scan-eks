variable "subnets" {
  description = "A list of subnet IDs to use for the Prowler cluster"
  type        = list(string)
}

variable "cluster_id" {
  description = "The ID of the ECS service"
  type        = string
}

variable "security_groups" {
  description = "A list of security groups to use for the Prowler container"
  type        = list(string)
}

variable "prowler_services" {
  description = "List of AWS services to scan with Prowler"
  type        = string
}

variable "bucket_name" {
  description = "Name of the S3 bucket to store reports"
  type        = string
}
