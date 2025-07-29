resource "tls_private_key" "ec2_ssh_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "ec2_key_pair" {
  key_name   = var.key_pair_name_prefix
  public_key = tls_private_key.ec2_ssh_key.public_key_openssh
}

resource "local_file" "ec2_private_key_file" {
  content         = tls_private_key.ec2_ssh_key.private_key_pem
  filename        = "${var.key_pair_name_prefix}.pem"
  file_permission = "0400"
}
