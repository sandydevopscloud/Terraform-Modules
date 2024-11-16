module "prod_vpc_1" {
  source             = "../modules/network"
  vpc_cidr_block     = "192.168.0.0/16"
  vpc_name           = "prod_vpc_1"
  environment        = "PRD"
  private_cidr_block = ["192.168.1.0/24", "192.168.2.0/24", "192.168.3.0/24"]
  public_cidr_block  = ["192.168.10.0/24", "192.168.20.0/24", "192.168.30.0/24"]
  azs                = ["eu-west-2a", "eu-west-2b", "eu-west-2c"]
}

module "prod_sg_1" {
  source        = "../modules/sg"
  vpc_name      = module.prod_vpc_1.vpc_name
  ingress_value = ["80", "443", "22", "3306", "1443", "8443", "1900"]
  environment   = module.prod_vpc_1.environment
  vpc_id        = module.prod_vpc_1.vpc_id
}

