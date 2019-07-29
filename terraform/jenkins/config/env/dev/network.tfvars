##################################################################################
# VARIABLES
##################################################################################

vpc_name_postfix            = "vpc"
public_subnet_name_postfix  = "public-subnet"
private_subnet_name_postfix = "private-subnet"

alb_security_group_name_postfix     = "alb-sg"
bastion_security_group_name_postfix = "bastion-sg"
ec2_security_group_name_postfix     = "jenkins-sg"

vpc_cidr            = "10.0.0.0/16"
subnet_count        = 6 // 50% public + 50% private (public + private per AZ)
subnet_mask_newbits = 3
ingress_cidrs       = ["188.114.87.10/32"]
