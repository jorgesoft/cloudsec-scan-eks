# Use this file as a configuration file

variable "vpc_id" {
  description = "The VPC to deploy the ECS"
  type        = string
  default     = "vpc-0cef7a71118c12024"
}

variable "cluster_name" {
  description = "The name of the ECS cluster"
  type        = string
  default = "my-ecs-cluster"
}

variable "subnets" {
  description = "A list of subnet IDs to use for the EKS cluster (only public supported by now)"
  type        = list(string)
  default = ["subnet-09f2197e07c30f6e7" ]
}

variable "ip_range" {
  description = "IP range to scan"
  type        = string
  default = "10.0.1.0/24"
}

variable "bucket_name" {
  description = "Name of the S3 bucket to store reports"
  type        = string
  default = "jorges-test"
}

variable "prowler_services" {
  description = "List of AWS services to scan with Prowler"
  type        = string
  default = "ec2 s3 ecs"
}

variable "ssh_password" {
  description = "Secure SSH password to connect to Pacu"
  type        = string
  sensitive   = true
}