module "staging_network" {
  source = "../modules/network"

  env                   = local.env
  cidr_block            = local.vpc_cidr_block
  private_subnets_cidrs = local.private_subnets_cidrs
  public_subnets_cidrs  = local.public_subnets_cidrs
  tags                  = local.tags
}

# module "staging_compute" {
#   source = "../modules/compute"
#
#   env                    = local.env
#   region                 = var.region
#   profile                = var.profile
#   access_cidrs           = var.my_ips_cidr
#   terraform_state_bucket = local.terraform_state_bucket
#
#   cluster_name    = module.staging_cluster.cluster_name
#   private_subnets = local.private_subnets_cidrs
#   public_subnets  = local.public_subnets_cidrs
#
#   tags = local.tags
# }
#
# module "staging_cluster" {
#   source = "../modules/cluster"
# 
#   env     = local.env
#   region  = var.region
#   profile = var.profile
#
#   tags = local.tags
# }
