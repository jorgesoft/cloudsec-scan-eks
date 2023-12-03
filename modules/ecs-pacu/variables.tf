variable "subnets" {
  description = "A list of subnet IDs to use for the EKS cluster"
  type        = list(string)
}

variable "cluster_id" {
  description = "The name of the ECS service"
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