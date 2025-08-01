resource "aws_instance" "web" {
  ami                    = data.aws_ssm_parameter.amazon_linux_2.value
  instance_type          = var.instance_type
  vpc_security_group_ids = [aws_security_group.sg_ec2.id]
  key_name               = aws_key_pair.ec2_key_pair.key_name
  subnet_id              = aws_subnet.public.id

  user_data = <<-EOF
              #!/bin/bash
              yum -y install httpd
              systemctl enable httpd
              systemctl start httpd
              echo '<html><h1>Olá do seu servidor web via terraform!</h1></html>' > /var/www/html/index.html
              EOF
}
