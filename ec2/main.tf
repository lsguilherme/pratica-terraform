# Configuração do provider aws
provider "aws" {
  region     = "us-east-1"
  profile = "seu profile"
}

# Providers
terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "~> 5.0"
    }
    tls = {
      source = "hashicorp/tls"
      version = "~> 4.0"
    }
    local = {
      source = "hashicorp/local"
      version = "~> 2.0"
    }
  }
}

# Criação da chave privada e publica

resource "tls_private_key" "ec2_ssh_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "ec2_key_pair" {
  key_name = "keypair_guilhermelacerda_tf"
  public_key = tls_private_key.ec2_ssh_key.public_key_openssh
}

resource "local_file" "ec2_private_key_file" {
  content = tls_private_key.ec2_ssh_key.private_key_pem
  filename = "keypair_guilhermelacerda_tf.pem"
  file_permission = "0400"
}

# Criação do security group do ec2

resource "aws_security_group" "sg_ec2" {
  name = "sg_ec2_guilhermelacerda_tf"
  description = "Permite qualquer acesso HTTP e SSH."
  vpc_id = "vpc-083305b6afaeb1096"

  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Permite SSH"
  }

  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Permite HTTP"
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Permite qualquer acesso"
  }

  tags = {
    Name = "sg_ec2_guilhermelacerda_tf"  
  }
}

# Criação da instância do ec2

resource "aws_instance" "web" {
  ami           = "ami-01edd5711cfe3825c"
  instance_type = "t2.micro"
  vpc_security_group_ids = [aws_security_group.sg_ec2.id]
  key_name = aws_key_pair.ec2_key_pair.key_name


  user_data = <<-EOF
              #!/bin/bash
              yum -y install httpd
              systemctl enable httpd
              systemctl start httpd
              echo '<html><h1>Olá do seu servidor web!</h1></html>' > /var/www/html/index.html
              EOF

  tags = {
    Name = "webserver-guilhermelacerda-tf"
  }
}


# Saídas

output "key_pair_name_output" {
  description = "Nome da Key Pair criada na AWS."
  value = aws_key_pair.ec2_key_pair.key_name
}

output "private_key_file_path" {
  description = "O caminho para o arquivo da chave privada."
  value = local_file.ec2_private_key_file.filename
}

output "security_group_id_output" {
  description = "O ID do Security Group criado."
  value = aws_security_group.sg_ec2.id
}

output "instace_public_id_output" {
  description = "O IP Público da instância EC2."
  value = aws_instance.web.public_ip
}
 