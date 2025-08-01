resource "tls_private_key" "ec2_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}
resource "aws_key_pair" "ec2_key" {
  key_name   = var.key_name
  public_key = tls_private_key.ec2_key.public_key_openssh

  tags = merge(
    var.owned_tags,
    {
      Name = var.key_name
    }
  )
  
}
resource "aws_ssm_parameter" "ec2_private_key" {
  name        = "/ec2/keypairs/${var.key_name}/private"
  description = "Private key for EC2 key pair prod-key"
  type        = "SecureString"
  value       = tls_private_key.ec2_key.private_key_pem

  tags = merge(
    var.owned_tags,
    {
    Name = "prod-key-private"
    }
  )
}