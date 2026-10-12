aws_region   = "us-east-1"
project-name = "prueba-tecnica-cusca"
cidr_block   = "10.0.0.0/16"

subnets = {
  sbn-public-z1 = {
    name       = "sbn-public-z1-p"
    cidr_block = "10.0.10.0/24"
    tier       = "public"
    az         = "us-east-1a"
  }

  sbn-public-z2 = {
    name       = "sbn-public-z2-p"
    cidr_block = "10.0.11.0/24"
    tier       = "public"
    az         = "us-east-1b"
  }

  sbn-private-z1 = {
    name       = "sbn-private-z1-p"
    cidr_block = "10.0.20.0/24"
    tier       = "private"
    az         = "us-east-1a"
  }

  sbn-private-z2 = {
    name       = "sbn-private-z2-p"
    cidr_block = "10.0.21.0/24"
    tier       = "private"
    az         = "us-east-1b"
  }
}

case_use_deploy                = "deploy"
case_use_app                   = "app"
deletion_window_in_days        = 30
eks_cluster_agent_role_name    = "eks-cluster-agent-role"
eks_node_group_agent_role_name = "eks-node-group-agent-role"
eks_cluster_app_role_name      = "eks-cluster-app-role"
eks_node_group_app_role_name   = "eks-node-group-app-role"
name_registry_app_image        = "pruebatecnica/cusca"
name_registry_dependencies     = "pruebatecnica/cusca-dependencies"
