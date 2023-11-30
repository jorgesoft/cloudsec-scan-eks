variable "vpc_id" {
  description = "The VPC ID where the cluster should be created"
  type        = string
}

variable "subnet_ids" {
  description = "A list of subnet IDs to use for the EKS cluster"
  type        = list(string)
}
