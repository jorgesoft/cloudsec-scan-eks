variable "subnets" {
  description = "A list of subnet IDs to use for the EKS cluster"
  type        = list(string)
}

variable "cluster_id" {
  description = "The name of the ECS service"
  type        = string
}

variable "security_groups" {
  description = "A list of subnet IDs to use for the EKS cluster"
  type        = list(string)
}

# variable "execution_role_arn" {
#   description = "The name of the ECS service"
#   type        = string
# }

variable "ip_range" {
  description = "IP range to scan"
  type        = string
}

variable "bucket_name" {
  description = "Name of the S3 bucket to store reports"
  type        = string
}
