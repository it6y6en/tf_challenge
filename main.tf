module "vpc" {
  source              = "./modules/vpc"
  vpc_cidr            = var.vpc_cidr
  num_public_subnets  = 3
  num_private_subnets = 3
}

module "ec2" {
  source        = "./modules/ec2"
  subnet_id     = module.vpc.public_subnet_ids[0]
  vpc_id        = module.vpc.vpc_id
  instance_type = var.instance_type
}
