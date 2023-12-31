# Use this file as a configuration file

variable "vpc_id" {
  description = "The VPC to deploy the ECS"
  type        = string
  default     = "vpc-0b3af7ee16aa7418f"
}

variable "cluster_name" {
  description = "The name of the ECS cluster"
  type        = string
  default = "my-ecs-cluster"
}

variable "log_group_name" {
  description = "The name of log group used by containers"
  type        = string
  default = "scan-ecs"
}

variable "subnets" {
  description = "A list of subnet IDs to use for the ECS cluster (only public supported by now)"
  type        = list(string)
  default = ["subnet-0debd0443dee835b4" ]
}

variable "ip_range" {
  description = "IP range to scan"
  type        = string
  default = "10.0.1.0/24"
}

variable "bucket_name" {
  description = "Name of the S3 bucket to store reports"
  type        = string
  default = "jorgestestings3"
}

variable "prowler_services" {
  description = "List of AWS services to scan with Prowler"
  type        = string
  default = "ec2 s3"
}

variable "ssh_password" {
  description = "Secure SSH password to connect to Pacu"
  type        = string
  sensitive   = true
}