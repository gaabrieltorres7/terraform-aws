variable "project_name" {
  type        = string
  description = "Project name to be used in resource tags"
}

variable "tags" {
  type        = map(string)
  description = "Tags to be applied to all resources"
}

variable "vpc_id" {
  type        = string
  description = "VPC ID where resources will be created"
}

variable "public_subnet" {
  type        = string
  description = "Public subnet ID for the bastion host"
}

variable "private_subnet" {
  type        = string
  description = "Private subnet ID for the Postgres instance"
}

variable "eks_cluster_sg_id" {
  type        = string
  description = "Security group ID for the EKS cluster"
}
