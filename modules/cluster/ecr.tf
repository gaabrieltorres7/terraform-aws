resource "aws_ecr_repository" "devops_lab_ecr" {
  name         = "${var.project_name}-ecr"
  force_delete = true
  tags         = var.tags
}
