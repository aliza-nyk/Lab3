module "security-group" {
  source = "./Template/security-group"
  vpc_id = module.vpc.vpc_id
}

module "hai" {
  source = "./Template/HAI"
  sg-id  = module.security-group.sg-tf-id
  vpc_id = module.vpc.vpc_id
  subnet = module.vpc.subnets
}

module "vpc" {
  source   = "./Template/vpc"
  vpc_type = "vpc-green"
}

