# Pacu container definition for ECS
resource "aws_ecs_task_definition" "pacu" {
  family                   = "pacu-service-tasks"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "256"
  memory                   = "512"
  execution_role_arn = aws_iam_role.pacu_task_role.arn
  task_role_arn      = aws_iam_role.pacu_task_role.arn
  container_definitions = jsonencode([
    {
      name  = "pacu_scanner"
      image = "gorje6/ecs-pacu:latest"
      essential = true
      logConfiguration = {
        logDriver = "awslogs",
        options = {
          awslogs-group         = var.log_group_name,
          awslogs-region        = "us-east-1",
          awslogs-stream-prefix = "ecs-pacu"
        }
      }
      environment = [
        {
          name  = "SSH_PASSWD",
          value = var.ssh_password
        }
      ]
      }     
  ])
}

# Service to deploy Pacu container in ECS
resource "aws_ecs_service" "pacu_service" {
  name            = "pacu_service"
  cluster         = var.cluster_id
  task_definition = aws_ecs_task_definition.pacu.arn
  launch_type     = "FARGATE"

  desired_count = 1

  network_configuration {
    subnets          = var.subnets
    security_groups  = [aws_security_group.pacu_sg.id]
    assign_public_ip = true
  }
}

# AIM role for Pacu container
resource "aws_iam_role" "pacu_task_role" {
  name = "pacu_task_role"

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

# AIM policy to allow Pacu container S3 access and logging 
resource "aws_iam_role_policy" "pacu_task_policy" {
  name   = "pacu_task_policy"
  role   = aws_iam_role.pacu_task_role.id

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
        Resource = "${var.log_group_arn}:*"
      }
    ],
  })
}

# Security group to allow SSH access to Pacu container
resource "aws_security_group" "pacu_sg" {
  vpc_id = var.vpc_id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Warning: This allows SSH from any IP
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
