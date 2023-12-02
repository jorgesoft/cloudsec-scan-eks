variable "vpc_id" {
  description = "The VPC to deploy the ECS"
  type        = string
  default     = "vpc-0468ee3f523e16f64"
}

variable "cluster_name" {
  description = "The name of the ECS cluster"
  type        = string
  default = "my-ecs-cluster"
}

variable "subnets" {
  description = "A list of subnet IDs to use for the EKS cluster"
  type        = list(string)
  default = ["subnet-0958873e28a701a5d" ]
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