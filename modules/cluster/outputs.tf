output "eks_cluster_name" {
  value       = aws_eks_cluster.eks_cluster.id
  description = "The name of the EKS cluster"
}

output "oidc" {
  value       = aws_eks_cluster.eks_cluster.identity[0].oidc[0].issuer
  description = "The OIDC issuer URL for the EKS cluster"
}

output "certificate_authority" {
  value       = aws_eks_cluster.eks_cluster.certificate_authority[0].data
  description = "The certificate authority data for the EKS cluster"
}

output "endpoint" {
  value       = aws_eks_cluster.eks_cluster.endpoint
  description = "The endpoint for the EKS cluster"
}

output "sg_id" {
  value       = aws_eks_cluster.eks_cluster.vpc_config[0].cluster_security_group_id
  description = "The security group ID for the EKS cluster"
}
