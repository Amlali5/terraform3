module "vpc" {
  source              = "./modules/vpc"
  vpc_cidr            = "10.0.0.0/16"
  public_subnet_cidrs = ["10.0.1.0/24", "10.0.2.0/24"]
  private_subnet_cidrs = ["10.0.3.0/24", "10.0.4.0/24"]
  azs                 = ["us-east-1a", "us-east-1b"]
}

module "security_group" {
  source = "./modules/security_group"
  vpc_id = module.vpc.vpc_id
}

module "load_balancer" {
  source            = "./modules/load_balancer"
  vpc_id            = module.vpc.vpc_id
  public_subnet_ids = module.vpc.public_subnet_ids
  private_subnet_ids = module.vpc.private_subnet_ids
  public_lb_sg_id   = module.security_group.public_lb_sg_id
  private_lb_sg_id  = module.security_group.private_lb_sg_id
  public_ec2        = module.ec2.public_instance_ids
  private_ec2       = module.ec2.private_instance_ids
}

module "ec2" {
  source            = "./modules/ec2"
  public_subnet_ids = module.vpc.public_subnet_ids
  private_subnet_ids = module.vpc.private_subnet_ids
  ami_id            = var.ami_id
  instance_type     = "t2.micro"
  public_sg_id      = module.security_group.public_ec2_sg_id
  private_sg_id     = module.security_group.private_ec2_sg_id
  key_name          = "my-key-pair"
  internal_lb_dns   = module.load_balancer.private_lb_dns
  nat_gateway_id = module.vpc.nat_gateway_id

}