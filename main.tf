module "vpc" {
  source              = "./modules/vpc"
  vpc_cidr            = var.vpc_cidr
  num_public_subnets  = 3
  num_private_subnets = 3
}
