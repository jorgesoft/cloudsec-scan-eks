variable "vpc_id" {
  description = "The VPC to deploy the ECS"
  type        = string
  default     = "vpc-0b76f02992879dee6"
}

variable "cluster_name" {
  description = "The name of the ECS cluster"
  type        = string
  default = "my-ecs-cluster"
}

variable "subnets" {
  description = "A list of subnet IDs to use for the EKS cluster"
  type        = list(string)
  default = ["subnet-0c787faa9f70ce401" ]
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
  description = "Name of the S3 bucket to store reports"
  type        = string
  default = "ec2"
}