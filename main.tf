provider "aws" {
  region = "us-east-1"  # Specify your AWS region
}

# Module for creating ECS Cluster
module "ecs_cluster" {
  source       = "./modules/ecs-cluster"
  cluster_name = var.cluster_name
  vpc_id = var.vpc_id
}

# Module for creating Nmap container
module "ecs_nmap_service" {
  source              = "./modules/ecs-nmap"
  cluster_id          = module.ecs_cluster.cluster_id
  subnets             = var.subnets 
  security_groups     = [module.ecs_cluster.security_group_id] 
  ip_range    = var.ip_range
  bucket_name = var.bucket_name
}

# Module for creating Prowler container
module "ecs_prowler_service" {
  source              = "./modules/ecs-prowler"
  cluster_id          = module.ecs_cluster.cluster_id
  subnets             = var.subnets 
  security_groups     = [module.ecs_cluster.security_group_id] 
  prowler_services    = var.prowler_services
  bucket_name = var.bucket_name
}

# Module for creating Pacu container
module "ecs_pacu_service" {
  source              = "./modules/ecs-pacu"
  cluster_id          = module.ecs_cluster.cluster_id
  subnets             = var.subnets 
  bucket_name = var.bucket_name
  vpc_id = var.vpc_id
  ssh_password = var.ssh_password
}