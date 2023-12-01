resource "aws_ecs_task_definition" "nmap" {
  family                   = "aws-scanning-lab"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "256"
  memory                   = "512"
  execution_role_arn       = var.execution_role_arn
  container_definitions = jsonencode([
    {
      name  = "nmap_scanner"
      image = "gorje6/ecs-nmap:latest" # Replace with your Docker image
      essential = true
      logConfiguration = {
        logDriver = "awslogs",
        options = {
          awslogs-group         = "ecs",
          awslogs-region        = "us-east-1",
          awslogs-stream-prefix = "ecs-nmap"
        }
      }      
      // Add other container definitions properties as required
    }
  ])
}

resource "aws_ecs_service" "nmap_service" {
  name            = "nmap_service"
  cluster         = var.cluster_id
  task_definition = aws_ecs_task_definition.nmap.arn
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
