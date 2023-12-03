# Prowler container definition
resource "aws_ecs_task_definition" "prowler" {
  family                   = "aws-scanning-lab"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "256"
  memory                   = "512"
  execution_role_arn = aws_iam_role.prowler_task_role.arn
  task_role_arn      = aws_iam_role.prowler_task_role.arn
  container_definitions = jsonencode([
    {
      name  = "prowler_scanner3"
      image = "gorje6/ecs-prowler:latest"
      essential = true
      logConfiguration = {
        logDriver = "awslogs",
        options = {
          awslogs-group         = "ecs",
          awslogs-region        = "us-east-1",
          awslogs-stream-prefix = "ecs-prowler"
        }
      }
      environment = [
        {
          name  = "PROWLER_SERVICES",
          value = var.prowler_services
        },
        {
          name  = "BUCKET_NAME",
          value = var.bucket_name
        }
      ]
      }     
  ])
}

# Prowler service deployment
resource "aws_ecs_service" "prowler_service" {
  name            = "prowler_service"
  cluster         = var.cluster_id
  task_definition = aws_ecs_task_definition.prowler.arn
  launch_type     = "FARGATE"

  desired_count = 1

  network_configuration {
    subnets          = var.subnets
    security_groups  = var.security_groups
    assign_public_ip = true
  }
}

# AIM role to Prowler container
resource "aws_iam_role" "prowler_task_role" {
  name = "prowler_task_role"

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

# Policy to give all the access needed for Prowler
# Documentation: https://github.com/prowler-cloud/prowler/tree/2.12.1#requirements-and-installation
resource "aws_iam_role_policy" "prowler_task_policy" {
  name   = "prowler_task_policy"
  role   = aws_iam_role.prowler_task_role.id

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "s3:PutObject",
          "s3:PutObjectAcl"
        ],
        Resource = "arn:aws:s3:::jorges-test/*"
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
      {
      "Action": [
        "account:Get*",
        "appstream:Describe*",
        "appstream:List*",
        "backup:List*",
        "cloudtrail:GetInsightSelectors",
        "codeartifact:List*",
        "codebuild:BatchGet*",
        "dlm:Get*",
        "drs:Describe*",
        "ds:Get*",
        "ds:Describe*",
        "ds:List*",
        "ec2:GetEbsEncryptionByDefault",
        "ecr:Describe*",
        "ecr:GetRegistryScanningConfiguration",
        "elasticfilesystem:DescribeBackupPolicy",
        "glue:GetConnections",
        "glue:GetSecurityConfiguration*",
        "glue:SearchTables",
        "lambda:GetFunction*",
        "logs:FilterLogEvents",
        "macie2:GetMacieSession",
        "s3:GetAccountPublicAccessBlock",
        "shield:DescribeProtection",
        "shield:GetSubscriptionState",
        "securityhub:BatchImportFindings",
        "securityhub:GetFindings",
        "ssm:GetDocument",
        "ssm-incidents:List*",
        "support:Describe*",
        "tag:GetTagKeys",
        "wellarchitected:List*"
      ],
      "Resource": "*",
      "Effect": "Allow",
      "Sid": "AllowMoreReadForProwler"
    },
    {
      "Effect": "Allow",
      "Action": [
        "apigateway:GET"
      ],
      "Resource": [
        "arn:aws:apigateway:*::/restapis/*",
        "arn:aws:apigateway:*::/apis/*"
      ]
    }
    ],
  })
}

# Attached required policies to Prowler role
# https://github.com/prowler-cloud/prowler/tree/2.12.1#requirements-and-installation
resource "aws_iam_role_policy_attachment" "security_audit" {
  role       = aws_iam_role.prowler_task_role.name
  policy_arn = "arn:aws:iam::aws:policy/SecurityAudit"
}

resource "aws_iam_role_policy_attachment" "view_only_access" {
  role       = aws_iam_role.prowler_task_role.name
  policy_arn = "arn:aws:iam::aws:policy/job-function/ViewOnlyAccess"
}
