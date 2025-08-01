resource "aws_security_group" "ec2_sg" {
  name        = var.ec2_instance.security_group.name
  description = var.ec2_instance.security_group.description
  vpc_id      = var.vpc_id

  dynamic "ingress" {
    for_each = var.ec2_instance.security_group.ingress
    content {
      from_port   = ingress.value.from_port
      to_port     = ingress.value.to_port
      protocol    = ingress.value.protocol
      cidr_blocks = ingress.value.cidr_blocks
    }
  }

  dynamic "egress" {
    for_each = var.ec2_instance.security_group.egress
    content {
      from_port   = egress.value.from_port
      to_port     = egress.value.to_port
      protocol    = egress.value.protocol
      cidr_blocks = egress.value.cidr_blocks
    }
  }

  tags = merge(
    var.owned_tags,
    {
      Name = var.ec2_instance.security_group.name
    }
  )
}



resource "aws_instance" "ec2-instances" {
  ami = var.ami_id
  instance_type = var.instance_type
  subnet_id = var.subnet_id
  vpc_security_group_ids = [aws_security_group.ec2_sg.id]
  key_name = var.key_name
  iam_instance_profile = var.ec2_instance.iam_instance_profile
  # iam_instance_profile = var.iam_instance_profile
#   user_data =<<-EOF
# #!/bin/bash
# sudo apt update -y
# sudo apt upgrade -y
# sudo apt install -y nginx
# sudo systemctl start nginx
# sudo systemctl enable nginx
# EOF

  tags = merge(
    var.owned_tags,
    {
      Name = var.instance_name
    }
  )

}