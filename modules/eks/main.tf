resource "aws_ecs_cluster" "cluster" {
  name = var.cluster_name
}

# Add any additional resources or configurations needed for the ECS cluster.
