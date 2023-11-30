resource "aws_ecs_task_definition" "task" {
  family                   = "my-task-family"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "256"
  memory                   = "512"
  execution_role_arn       = var.execution_role_arn
  container_definitions = jsonencode([
    {
      name  = "nginx-container"
      image = "nginx:latest" # Replace with your Docker image
      portMappings = [
        {
          containerPort = 80
          hostPort      = 80
        }
      ]
      // Add other container definitions properties as required
    }
  ])
}

resource "aws_ecs_service" "service" {
  name            = "my-ecs-service"
  cluster         = var.cluster_id
  task_definition = aws_ecs_task_definition.task.arn
  launch_type     = "FARGATE"

  desired_count = 1

  network_configuration {
    subnets          = var.subnets
    security_groups  = var.security_groups
    assign_public_ip = true
  }

  # Depending on your needs, you might want to add load balancer configurations or service discovery settings here.
}

# Here, you can add more resources or configurations related to the ECS service if needed.
# For example, auto-scaling configurations.
