variable "cidr_block" {
  type        = string
  description = "Networking CIDR block to be used for the VPC"
}

variable "project_name" {
  type        = string
  description = "Project name to be used in resource tags"
}

variable "tags" {
  type        = map(string)
  description = "Tags to be applied to all resources"
}
