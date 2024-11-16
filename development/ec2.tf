module "dev_ec2_1" {
  source      = "../modules/compute"
  environment = module.dev_vpc_1.environment
  amis = {
    eu-north-1 = "ami-08eb150f611ca277f"
    eu-west-2  = "ami-0e8d228ad90af673b"
  }
  region_name          = var.region_name
  ec2_inst_type        = "t2.micro"
  key_name             = "sandy-pem"
  public_subnet        = module.dev_vpc_1.public_subnets_id
  sg_id                = module.dev_sg_1.sg_id
  vpc_name             = module.dev_vpc_1.vpc_name
  private_subnet       = module.dev_vpc_1.private_subnets_id
  iam_instance_profile = module.dev_iam_profile_1.iam_instance_profile_name
  elb_listener         = module.dev_elb_1.elb_listner
  elb_listener_public  = module.dev_elb_1_public.elb_listner
}

module "dev_elb_1" {
  source          = "../modules/elb"
  lb_name         = "dev-nlb"
  target_group    = "dev-nlb-tg"
  subnets         = module.dev_vpc_1.public_subnets_id
  environment     = module.dev_vpc_1.environment
  vpc_id          = module.dev_vpc_1.vpc_id
  private_servers = module.dev_ec2_1.private_servers
}

module "dev_elb_1_public" {
  source          = "../modules/elb"
  lb_name         = "dev-nlb-public"
  subnets         = module.dev_vpc_1.public_subnets_id
  environment     = module.dev_vpc_1.environment
  target_group    = "dev-nlb-tg-public"
  vpc_id          = module.dev_vpc_1.vpc_id
  private_servers = module.dev_ec2_1.public_servers
}

module "dev_iam_profile_1" {
  source                = "../modules/iam"
  role_name             = "Sandy-IAM-Role"
  environment           = module.dev_vpc_1.environment
  instance_profile_name = "Sandy-Instance-Profile"
}

