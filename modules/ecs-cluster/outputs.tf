output "cluster_id" {
  description = "The ID of the ECS cluster"
  value       = aws_ecs_cluster.cluster.id
}

output "execution_role_arn" {
  value = aws_iam_role.ecs_execution_role.arn
}

output "security_group_id" {
  value = aws_security_group.ecs_sg.id
}
