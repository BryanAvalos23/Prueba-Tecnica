variable "aws_region" {
  description = "La región de AWS donde se desplegarán los recursos."
  type        = string
}

variable "cidr_block" {
  description = "El bloque CIDR para la VPC."
  type        = string
}

variable "project-name" {
  description = "El nombre del proyecto para etiquetar los recursos."
  type        = string
}

variable "subnets" {
  type = map(object({
    name       = string
    cidr_block = string
    tier       = string
    az         = string
  }))
}

variable "deletion_window_in_days" {
  description = "Cantidad de días antes de eliminar la llave KMS programada para borrado."
  type        = number
}

variable "case_use_deploy" {
  description = "Caso de uso para diferenciar los clústeres EKS."
  type        = string
}

variable "case_use_app" {
  description = "Caso de uso para diferenciar los clústeres EKS de la aplicación."
  type        = string
}

variable "eks_cluster_agent_role_name" {
  description = "Nombre del rol IAM para el agente del clúster EKS."
  type        = string
}

variable "eks_node_group_agent_role_name" {
  description = "Nombre del rol IAM para el agente del grupo de nodos EKS."
  type        = string
}

variable "eks_cluster_app_role_name" {
  description = "Nombre del rol IAM para el clúster EKS de la aplicación."
  type        = string
}

variable "eks_node_group_app_role_name" {
  description = "Nombre del rol IAM para el grupo de nodos EKS de la aplicación."
  type        = string
}

variable "name_registry_app_image" {
  description = "El nombre del registro de ECR para las imágenes de la aplicación."
  type        = string
}

variable "name_registry_dependencies" {
  description = "El nombre del registro de ECR para las imágenes de dependencias."
  type        = string
}

# variable "admin_role" {
#   description = "ARN del rol IAM para el acceso administrativo al clúster EKS."
#   type        = string
# }
