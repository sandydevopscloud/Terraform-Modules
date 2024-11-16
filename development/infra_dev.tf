module "dev_vpc_1" {
  source             = "../modules/network"
  vpc_cidr_block     = "10.0.0.0/16"
  vpc_name           = "dev_vpc_1"
  environment        = "DEV"
  private_cidr_block = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  public_cidr_block  = ["10.0.10.0/24", "10.0.20.0/24", "10.0.30.0/24"]
  azs                = ["eu-west-2a", "eu-west-2b", "eu-west-2c"]
  natgw_id           = module.dev_natgw_1.natgw_id
}

module "dev_natgw_1" {
  source           = "../modules/nat"
  environment      = "DEV"
  public_subnet_id = module.dev_vpc_1.public_subnets_id
  vpc_name         = module.dev_vpc_1.vpc_name
}

