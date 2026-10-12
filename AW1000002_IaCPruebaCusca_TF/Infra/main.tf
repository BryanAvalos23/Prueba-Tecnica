module "vpc" {
  source       = "./modules/Networking/VPC"
  project-name = var.project-name
  cidr_block   = var.cidr_block
  aws_region   = var.aws_region
}

module "subnets" {
  source = "./modules/Networking/subnets"

  project-name = var.project-name
  vpc_id       = module.vpc.principal

  subnets = var.subnets
}

module "igw" {
  source = "./modules/Networking/internet-gateway"

  project-name = var.project-name
  vpc_id       = module.vpc.principal
}

module "route_tables" {
  source = "./modules/Networking/route-tables"

  project-name = var.project-name
  vpc_id       = module.vpc.principal
  igw_id       = module.igw.igw_id
  subnets      = module.subnets.subnet_ids
}

module "vpc_endpoints" {
  source = "./modules/Networking/vpc-endpoints"

  vpc_id                  = module.vpc.principal
  project-name            = var.project-name
  region                  = var.aws_region
  subnet_private_ids      = module.subnets.subnet_private_ids
  private_route_table_ids = module.route_tables.private_route_table_ids
  vpc_cidr                = var.cidr_block
}

module "kms" {
  source = "./modules/KMS"

  project-name            = var.project-name
  description             = "Clave KMS para cifrar los recursos del proyecto."
  deletion_window_in_days = var.deletion_window_in_days
  alias_name              = "${var.project-name}-kms-key"
}

module "ecr" {
  source        = "./modules/ECR"
  name_registry = var.name_registry_app_image

  project-name = var.project-name
}

module "ecr_dependencies" {
  source        = "./modules/ECR"
  name_registry = var.name_registry_dependencies

  project-name = var.project-name
}

module "iam_eks_deploy" {
  source = "./modules/IAM"

  eks_cluster_role_name    = var.eks_cluster_agent_role_name
  eks_node_group_role_name = var.eks_node_group_agent_role_name
}

module "iam_eks_app" {
  source = "./modules/IAM"

  eks_cluster_role_name    = var.eks_cluster_app_role_name
  eks_node_group_role_name = var.eks_node_group_app_role_name
}

module "eks_deploy" {
  source = "./modules/EKS"

  project-name            = var.project-name
  eks_cluster_role_arn    = module.iam_eks_deploy.eks_cluster_role_arn
  subnet_ids              = module.subnets.subnet_public_ids
  eks_node_group_role_arn = module.iam_eks_deploy.eks_node_group_role_arn
  vpc_id                  = module.vpc.principal
  cidr_block              = var.cidr_block
  case_use                = var.case_use_deploy
}

module "eks_app" {
  source = "./modules/EKS"

  project-name            = var.project-name
  eks_cluster_role_arn    = module.iam_eks_app.eks_cluster_role_arn
  subnet_ids              = module.subnets.subnet_private_ids
  eks_node_group_role_arn = module.iam_eks_app.eks_node_group_role_arn
  vpc_id                  = module.vpc.principal
  cidr_block              = var.cidr_block
  case_use                = var.case_use_app
}
