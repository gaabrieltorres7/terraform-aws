variable "project_name" {
  type        = string
  description = "Project name to be used in resource tags"
}

variable "tags" {
  type        = map(string)
  description = "Tags to be applied to all resources"
}

variable "oidc_issuer_url" {
  type        = string
  description = "The OIDC issuer URL for the EKS cluster"
}

variable "eks_cluster_name" {
  type        = string
  description = "The name of the EKS cluster"
}

variable "vpc_id" {
  type        = string
  description = "The ID of the VPC where the EKS cluster is deployed"
}
