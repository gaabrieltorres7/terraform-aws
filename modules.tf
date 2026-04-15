module "eks_network" {
  source       = "./modules/network"
  project_name = var.project_name
  cidr_block   = var.cidr_block
  tags         = var.tags
}

module "eks_cluster" {
  source           = "./modules/cluster"
  project_name     = var.project_name
  public_subnet_1a = module.eks_network.subnet_public_1a
  public_subnet_1b = module.eks_network.subnet_public_1b
  tags             = var.tags
}

module "eks_managed_node_group" {
  source            = "./modules/managed-node-group"
  project_name      = var.project_name
  cluster_name      = module.eks_cluster.eks_cluster_name
  private_subnet_1a = module.eks_network.subnet_private_1a
  private_subnet_1b = module.eks_network.subnet_private_1b
  tags              = var.tags
}

module "eks_add_ons" {
  source           = "./modules/add-ons"
  project_name     = var.project_name
  oidc_issuer_url  = module.eks_cluster.oidc
  eks_cluster_name = module.eks_cluster.eks_cluster_name
  vpc_id           = module.eks_network.vpc_id
  tags             = var.tags
}

module "eks_ec2" {
  source            = "./modules/ec2/"
  project_name      = var.project_name
  vpc_id            = module.eks_network.vpc_id
  public_subnet     = module.eks_network.subnet_public_1a
  private_subnet    = module.eks_network.subnet_private_1a
  eks_cluster_sg_id = module.eks_cluster.sg_id
  tags              = var.tags
}
