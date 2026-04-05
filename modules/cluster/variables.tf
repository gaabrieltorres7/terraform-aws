variable "project_name" {
  type        = string
  description = "Project name to be used in resource tags"
}

variable "tags" {
  type        = map(string)
  description = "Tags to be applied to all resources"
}

variable "public_subnet_1a" {
  type        = string
  description = "Subnet to create EKS cluster in availability zone 1a"
}

variable "public_subnet_1b" {
  type        = string
  description = "Subnet to create EKS cluster in availability zone 1b"
}
