variable "cluster_endpoint" {
  description = "EKS cluster endpoint"
  type        = string
}

variable "cluster_certificate_authority" {
  description = "EKS cluster CA certificate"
  type        = string
}

variable "cluster_token" {
  description = "Token for EKS cluster authentication"
  type        = string
}

# Define other variables as needed
