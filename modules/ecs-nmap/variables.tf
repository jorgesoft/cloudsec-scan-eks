variable "subnets" {
  description = "A list of subnet IDs to use for the Nmap container"
  type        = list(string)
}

variable "cluster_id" {
  description = "The ID of the ECS cluster"
  type        = string
}

variable "ip_range" {
  description = "IP range to scan"
  type        = string
}

variable "bucket_name" {
  description = "Name of the S3 bucket to store reports"
  type        = string
}
