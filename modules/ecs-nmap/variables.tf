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

variable "execution_role_arn" {
  description = "The name of the ECS service"
  type        = string
}