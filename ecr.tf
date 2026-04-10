resource "aws_ecr_repository" "devops_lab_ecr" {
  name         = "devops-lab-ecr"
  force_delete = true
  tags         = var.tags
}
