resource "aws_iam_role" "lambda_role" {
  name = "lambda_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Sid    = "",
        Effect = "Allow",
        Principal = {
          Service = "lambda.amazonaws.com"
        },
        Action = "sts:AssumeRole"
      }
    ]
  })
}


resource "aws_iam_role_policy" "lambda_role" {
  name = "lambda_role"
    role = aws_iam_role.lambda_role.name
    policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
        {
			"Sid": "VisualEditor0",
			"Effect": "Allow",
			"Action": [
				"ec2:CreateNetworkInterface",
				"logs:CreateLogStream",
				"ec2:DescribeNetworkInterfaces",
				"ec2:CreateTags",
				"ec2:DeleteNetworkInterface",
				"ec2:UnassignPrivateIpAddresses",
				"ec2:DescribeSubnets",
				"ec2:AssignPrivateIpAddresses",
				"logs:CreateLogGroup",
				"logs:PutLogEvents"
			],
			"Resource": "*"
		},
        {
			"Sid": "VisualEditor1",
			"Effect": "Allow",
			"Action": "s3:*",
			"Resource": [
				"arn:aws:s3:::bootlabs-dev/*",
				"arn:aws:s3:::bootlabs-dev"
			]
		}
    ]
  })
}

resource "aws_iam_role_policy_attachment" "lambda_basic" {
  role       = aws_iam_role.lambda_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

