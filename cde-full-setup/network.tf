module "vpc" {
  source                  = "cloudposse/vpc/aws"
  version                 = "2.1.0"
  ipv4_primary_cidr_block = "10.0.0.0/16"
  name                    = "cloud-developer-environments"
}


module "subnets" {
  source  = "cloudposse/dynamic-subnets/aws"
  version = "2.4.1"

  vpc_id                  = module.vpc.vpc_id
  igw_id                  = [module.vpc.igw_id]
  nat_gateway_enabled     = false
  nat_instance_enabled    = false
  name                    = "cloud-developer-environments"
  private_subnets_enabled = false
  public_subnets_enabled  = true
}

resource "aws_security_group" "cloud-developer-environments" {
  name        = "cloud-developer-environments"
  description = "cloud-developer-environments"
  vpc_id      = module.vpc.vpc_id
}


resource "aws_security_group_rule" "cloud-developer-environments_egress_all_ipv4" {
  type              = "egress"
  from_port         = 0
  to_port           = 65535
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.cloud-developer-environments.id
}

resource "aws_security_group_rule" "allow_all_within_group" {
  security_group_id = aws_security_group.cloud-developer-environments.id
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
}
