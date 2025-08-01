output "id" {
    description = "id of the ec2 instance"
    value = aws_instance.ec2-instances.id
}

output "public_ip" {
    description = "public ip of ec2 instances"
    value = aws_instance.ec2-instances.public_ip 
}

output "private_ip" {
    description = "private ip of ec2 instances"
    value = aws_instance.ec2-instances.private_ip 
}