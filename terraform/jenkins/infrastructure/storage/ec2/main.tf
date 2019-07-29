##################################################################################
# LOCALS
##################################################################################

locals {}

##################################################################################
# RESOURCES
##################################################################################

resource "tls_private_key" "key" {
  algorithm = "RSA"
  rsa_bits  = 2048
}

resource "aws_key_pair" "key_pair" {
  key_name   = module.ec2-key-pair.resource-name
  public_key = tls_private_key.key.public_key_openssh

  depends_on = [tls_private_key.key]
}

resource "local_file" "key_pem" {
  filename = "${module.ec2-key-pair.resource-name}.pem"
  content  = tls_private_key.key.private_key_pem
}
