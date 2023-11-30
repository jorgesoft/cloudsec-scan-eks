variable "vpc_id" {
  description = "The VPC to deploy the ECS"
  type        = string
  default     = "vpc-00aa06d88f8431bd3"
}

variable "cluster_name" {
  description = "The name of the ECS cluster"
  type        = string
  default = "my-ecs-cluster"
}

variable "subnets" {
  description = "A list of subnet IDs to use for the EKS cluster"
  type        = list(string)
  default = ["subnet-00b288a7d2713bee0" ]
}
