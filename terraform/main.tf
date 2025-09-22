# VPC - Creates the VPC, subnets, IGW, and the RT
module "vpc" {
    source = "./modules/vpc"
    env_name = var.env_name
    cidr_block = local.vpc_cidr_block
    availability_zones = var.availability_zones
    public_subnet_cidrs = local.public_subnet_cidrs
    private_subnet_cidrs = local.private_subnet_cidrs
}

# SGs - Creates the Public/Private SGs and their respective ingress/egress rules
module "security_groups" {
    source = "./modules/security-groups"
    env_name = var.env_name
    vpc_id = module.vpc.vpc_id
}

# ACM - Uses TLS for generating the private key & self signed cert - import to ACM
module "acm" {
    source = "./modules/acm"
    domain_name = var.domain_name
}

# ALB - Creates the public ALB, TG, and both listeners
module "alb" {
    source = "./modules/alb"
    env_name = var.env_name
    vpc_id = module.vpc.vpc_id
    public_subnets = module.vpc.public_subnet_ids
    alb_sg = module.security_groups.alb_sg_id
    certificate_arn = module.acm.certificate_arn
}

# R53 - Creates the R53 hosted zone and both alias records
module "route53" {
    source = "./modules/route53"
    hosted_zone_name = var.domain_name
    public_alb_dns_name = module.alb.public_alb_dns_name
    public_alb_dns_zone_id = module.alb.public_alb_dns_zone_id
}

# EC2 - Grabs the latest AWS Linux 2023 AMI, launch template, and ASG
module "ec2" {
    source = "./modules/ec2"
    env_name = var.env_name
    webserver_ec2_instance_type = "t3.micro"
    ec2_sg = module.security_groups.webserver_sg_id
    private_subnet_ids = module.vpc.private_subnet_ids
    webserver_tg_arn = module.alb.webserver_tg_arn
    create_asg_service_linked_role = false
}