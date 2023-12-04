# Nmap container defintion to ECS
resource "aws_ecs_task_definition" "nmap" {
  family                   = "nmap-service-tasks"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "256"
  memory                   = "512"
  execution_role_arn = aws_iam_role.nmap_task_role.arn
  task_role_arn      = aws_iam_role.nmap_task_role.arn
  container_definitions = jsonencode([
    {
      name  = "nmap_scanner"
      image = "gorje6/ecs-nmap:latest"
      essential = true
      logConfiguration = {
        logDriver = "awslogs",
        options = {
          awslogs-group         = "ecs",
          awslogs-region        = "us-east-1",
          awslogs-stream-prefix = "ecs-nmap"
        }
      }
      environment = [
        {
          name  = "IP_RANGE",
          value = var.ip_range
        },
        {
          name  = "BUCKET_NAME",
          value = var.bucket_name
        }
      ]
      }     
  ])
}

# Nmap service deployment on ECS
resource "aws_ecs_service" "nmap_service" {
  name            = "nmap_service"
  cluster         = var.cluster_id
  task_definition = aws_ecs_task_definition.nmap.arn
  launch_type     = "FARGATE"

  desired_count = 1

  network_configuration {
    subnets          = var.subnets
    #security_groups  = var.security_groups
    assign_public_ip = true
  }
}

# Role to attach to Nmap container
resource "aws_iam_role" "nmap_task_role" {
  name = "nmap_task_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = "sts:AssumeRole",
        Principal = {
          Service = "ecs-tasks.amazonaws.com"
        },
      },
    ],
  })
}

# Nmap AIM policy to allow S3 access and logging
resource "aws_iam_role_policy" "nmap_task_policy" {
  name   = "nmap_task_policy"
  role   = aws_iam_role.nmap_task_role.id

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "s3:PutObject",
          "s3:PutObjectAcl"
        ],
        Resource = "arn:aws:s3:::${var.bucket_name}/*"
      },
      {
        Effect = "Allow",
        Action = [
          "logs:CreateLogStream",
          "logs:PutLogEvents",
          "logs:CreateLogGroup"
        ],
        Resource = "arn:aws:logs:us-east-1:569381557655:log-group:ecs:*"
      },
    ],
  })
}
