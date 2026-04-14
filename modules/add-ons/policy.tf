resource "aws_iam_policy" "eks_controller_policy" {
  name   = "${var.project_name}-lb-controller-policy"
  policy = file("${path.module}/iam-policy.json")
  tags   = var.tags
}
