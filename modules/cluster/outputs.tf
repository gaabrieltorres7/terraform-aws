output "eks_cluster_name" {
  value       = aws_eks_cluster.eks_cluster.id
  description = "The name of the EKS cluster"
}
