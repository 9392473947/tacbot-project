resource "aws_iam_role" "ec2_role_app1" {
  name = "app1-ec2-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Action = "sts:AssumeRole",
      Effect = "Allow",
      Principal = {
        Service = "ec2.amazonaws.com"
      }
    }]
  })
}

resource "aws_iam_instance_profile" "app1_instance_profile" {
  name = "app1-ec2-profile"
  role = aws_iam_role.ec2_role_app1.name
}
