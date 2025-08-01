output "key_pair_name_output" {
  description = "Nome da Key Pair criada na AWS."
  value       = aws_key_pair.ec2_key_pair.key_name
}

output "private_key_file_path" {
  description = "O caminho para o arquivo da chave privada."
  value       = local_file.ec2_private_key_file.filename
}

output "security_group_id_output" {
  description = "O ID do Security Group criado."
  value       = aws_security_group.sg_ec2.id
}

output "instace_public_id_output" {
  description = "O IP Público da instância EC2."
  value       = aws_instance.web.public_ip
}

output "vpc_id" {
  description = "ID da VPC"
  value       = aws_vpc.main.id
}
