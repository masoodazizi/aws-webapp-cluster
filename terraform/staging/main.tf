module "staging_network" {
  source = "../modules/network"

  env                   = "${local.env}"
  cidr_block            = "${local.vpc_cidr_block}"
  private_subnets_cidrs = "${local.private_subnets_cidrs}"
  public_subnets_cidrs  = "${local.public_subnets_cidrs}"
  tags                  = "${local.tags}"
}
