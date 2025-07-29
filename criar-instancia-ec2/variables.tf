variable "aws_region" {
  description = "Região da AWS onde será provisionado os recursos."
  type        = string
  default     = "us-east-1"
}

variable "aws_profile" {
  description = "Perfil da AWS a ser utilizado do aws configure."
  type        = string
  default     = "lacerdagui42@gmail.com"
}

variable "vpc_id" {
  description = "ID da VPC onde o security group será criado."
  type        = string
  default     = "vpc-083305b6afaeb1096"
}

variable "instance_type" {
  description = "Tipo da instância EC2"
  type        = string
  default     = "t2.micro"
}

variable "key_pair_name_prefix" {
  description = "Prefixo do nome da Key Pair criada na AWS."
  type        = string
  default     = "parchave_guilhermelacerda_tf"
}

variable "sg_name" {
  description = "Nome do security group para instância EC2."
  type        = string
  default     = "sg_ec2_guilhermelacerda_tf"
}
