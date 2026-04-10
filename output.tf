output "certificate_authority" {
  value = module.eks_cluster.certificate_authority
}

output "endpoint" {
  value = module.eks_cluster.endpoint
}

output "eks_cluster_name" {
  value = module.eks_cluster.eks_cluster_name
}
