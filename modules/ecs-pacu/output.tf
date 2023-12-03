output "service_id" {
  description = "The ID of the ECS service"
  value       = aws_ecs_service.pacu_service.id
}