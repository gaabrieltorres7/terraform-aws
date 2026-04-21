resource "aws_route53_zone" "devops_lab" {
  name = "devopslab.com.br"
  tags = var.tags
}
