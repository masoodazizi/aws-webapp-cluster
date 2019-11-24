module "staging_network" {
  source = "../modules/network"

  env                   = "${local.env}"
  cidr_block            = "10.10.0.0/16"
  private_subnets_cidrs = ["10.10.10.0/24", "10.10.11.0/24"]
  public_subnets_cidrs  = ["10.10.20.0/24", "10.10.21.0/24"]
  tags                  = "${local.tags}"
}
