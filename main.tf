provider "aws" {
  region = "us-east-1"  # Specify your AWS region
}

# Module for creating ECS Cluster
module "ecs_cluster" {
  source       = "./modules/ecs-cluster"
  cluster_name = var.cluster_name
  vpc_id = var.vpc_id
}

# Module for creating ECS Service and Task Definition
module "ecs_service" {
  source              = "./modules/ecs-service"
  cluster_id          = module.ecs_cluster.cluster_id
  execution_role_arn  = module.ecs_cluster.execution_role_arn
  subnets             = var.subnets # Replace with your subnet IDs
  security_groups     = [module.ecs_cluster.security_group_id] # Replace with your security group ID
}

# You can also define outputs here if you need to expose any information from the modules
