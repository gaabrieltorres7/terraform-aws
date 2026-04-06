variable "project_name" {
  type        = string
  description = "Project name to be used in resource tags"
}

variable "tags" {
  type        = map(string)
  description = "Tags to be applied to all resources"
}

variable "cluster_name" {
  type        = string
  description = "Name of the EKS cluster to which the node group will be attached"
}

variable "private_subnet_1a" {
  type        = string
  description = "Subnet ID from AZ 1a"
}

variable "private_subnet_1b" {
  type        = string
  description = "Subnet ID from AZ 1b"
}
