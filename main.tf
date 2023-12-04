provider "aws" {
  region = "us-east-1"  # Specify your AWS region
}

# Module for creating ECS Cluster
module "ecs_cluster" {
  source       = "./modules/ecs-cluster"
  cluster_name = var.cluster_name
  vpc_id = var.vpc_id
}

# Module for creating log group
module "cloudwatch_log_group" {
  source         = "./modules/log-group"  # Update this path to your module's location
  log_group_name = var.log_group_name
}

# Module for creating Nmap container
module "ecs_nmap_service" {
  source              = "./modules/ecs-nmap"
  cluster_id          = module.ecs_cluster.cluster_id
  subnets             = var.subnets
  ip_range    = var.ip_range
  bucket_name = var.bucket_name
  log_group_name = var.log_group_name
  log_group_arn = module.cloudwatch_log_group.log_group_arn
}

# Module for creating Prowler container
module "ecs_prowler_service" {
  source              = "./modules/ecs-prowler"
  cluster_id          = module.ecs_cluster.cluster_id
  subnets             = var.subnets
  prowler_services    = var.prowler_services
  bucket_name = var.bucket_name
  log_group_name = var.log_group_name
  log_group_arn = module.cloudwatch_log_group.log_group_arn
}

# Module for creating Pacu container
module "ecs_pacu_service" {
  source              = "./modules/ecs-pacu"
  cluster_id          = module.ecs_cluster.cluster_id
  subnets             = var.subnets 
  bucket_name = var.bucket_name
  vpc_id = var.vpc_id
  ssh_password = var.ssh_password
  log_group_name = var.log_group_name
  log_group_arn = module.cloudwatch_log_group.log_group_arn
}