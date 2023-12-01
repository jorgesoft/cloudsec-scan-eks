terraform {
  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.0"  # Specify the version here
    }
  }
}

provider "kubernetes" {
  host                   = var.cluster_endpoint
  cluster_ca_certificate = base64decode(var.cluster_certificate_authority)
  token                  = var.cluster_token
  #load_config_file       = false
}

# ... Kubernetes resource definitions ...
resource "kubernetes_pod" "example" {
  metadata {
    name = "example-pod"
  }

  spec {
    container {
      image = "nginx:latest"
      name  = "nginx"
    }
  }
}
