output "service_id" {
  description = "The ID of the ECS service"
  value       = aws_ecs_service.nmap_service.id
}
