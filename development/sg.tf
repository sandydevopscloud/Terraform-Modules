module "dev_sg_1" {
  source        = "../modules/sg"
  vpc_name      = module.dev_vpc_1.vpc_name
  ingress_value = ["80", "443", "22", "3306", "1443", "8443", "1900"]
  environment   = module.dev_vpc_1.environment
  vpc_id        = module.dev_vpc_1.vpc_id
}
