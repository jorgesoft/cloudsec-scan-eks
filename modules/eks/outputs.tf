# In outputs.tf of your EKS module

output "cluster_id" {
  value       = aws_eks_cluster.cluster.id
  description = "The ID of the EKS cluster"
}

output "cluster_endpoint" {
  value       = aws_eks_cluster.cluster.endpoint
  description = "The endpoint for the EKS cluster API"
}

output "cluster_certificate_authority" {
  value       = aws_eks_cluster.cluster.certificate_authority[0].data
  description = "The certificate authority data for the EKS cluster"
}

output "node_group_id" {
  value       = aws_eks_node_group.node_group.id
  description = "The ID of the EKS node group"
}
