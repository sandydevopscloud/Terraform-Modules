module "prod_ec2_1" {
  source      = "../modules/compute"
  environment = module.prod_vpc_1.environment
  amis = {
    eu-north-1 = "ami-08eb150f611ca277f"
    eu-west-2  = "ami-0e8d228ad90af673b"
  }
  region_name    = var.region_name
  ec2_inst_type  = "t2.micro"
  key_name       = "sandy-pem"
  public_subnet  = module.prod_vpc_1.public_subnet
  sg_id          = module.prod_sg_1.sg_id
  vpc_name       = module.prod_vpc_1.vpc_name
  private_subnet = module.prod_vpc_1.private_subnet
}
