projectname = "tacbot"

owned_tags = {
  Environment = "prod"
  Owner       = "chaithu"
}

iam_roles = {
  tacbot-role = {
    role_name = "eks-oidc-role"
    assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Federated": "arn:aws:iam::992382670521:oidc-provider/oidc.eks.us-east-1.amazonaws.com/id/FD3865B3EC21DE7225BCC1DF1328C4CA"
      },
      "Action": "sts:AssumeRoleWithWebIdentity",
      "Condition": {
        "StringEquals": {
          "oidc.eks.us-east-1.amazonaws.com/id/FD3865B3EC21DE7225BCC1DF1328C4CA:aud": "sts.amazonaws.com",
          "oidc.eks.us-east-1.amazonaws.com/id/FD3865B3EC21DE7225BCC1DF1328C4CA:sub": [
            "system:serviceaccount:default:tacbot-backend",
            "system:serviceaccount:default:tacbot-ai",
            "system:serviceaccount:uat:tacbot-backend-uat"
          ]
        }
      }
    }
  ]
}
EOF

    inline_policies = {
      tacbot-inline-policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "VisualEditor0",
      "Effect": "Allow",
      "Action": [
        "secretsmanager:DescribeSecret",
        "s3:*",
        "secretsmanager:PutSecretValue",
        "secretsmanager:CreateSecret",
        "secretsmanager:DeleteSecret",
        "secretsmanager:CancelRotateSecret",
        "secretsmanager:UpdateSecret",
        "secretsmanager:GetSecretValue",
        "secretsmanager:StopReplicationToReplica",
        "secretsmanager:ReplicateSecretToRegions",
        "ses:*",
        "secretsmanager:RestoreSecret",
        "secretsmanager:RotateSecret",
        "secretsmanager:UpdateSecretVersionStage",
        "secretsmanager:RemoveRegionsFromReplication"
      ],
      "Resource": "*"
    }
  ]
}
EOF

tacbot-logs-policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "AllowLogs",
      "Effect": "Allow",
      "Action": [
        "logs:CreateLogGroup",
        "logs:CreateLogStream",
        "logs:PutLogEvents"
      ],
      "Resource": "*"
    }
  ]
}
EOF
    }

    managed_policy_arns = [
      "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
    ]
  }

  eks-role = {
    role_name = "eks-role"
    assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Federated": "arn:aws:iam::992382670521:oidc-provider/oidc.eks.us-east-1.amazonaws.com/id/FD3865B3EC21DE7225BCC1DF1328C4CA"
      },
      "Action": "sts:AssumeRoleWithWebIdentity",
      "Condition": {
        "StringEquals": {
          "oidc.eks.us-east-1.amazonaws.com/id/FD3865B3EC21DE7225BCC1DF1328C4CA:aud": "sts.amazonaws.com",
          "oidc.eks.us-east-1.amazonaws.com/id/FD3865B3EC21DE7225BCC1DF1328C4CA:sub": [
            "system:serviceaccount:default:tacbot-backend",
            "system:serviceaccount:default:tacbot-ai",
            "system:serviceaccount:uat:tacbot-backend-uat"
          ]
        }
      }
    }
  ]
}
EOF

    inline_policies = {
      eks-policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "VisualEditor0",
      "Effect": "Allow",
      "Action": ["s3:*", "secretsmanager:*", "ses:*"],
      "Resource": "*"
    }
  ]
}
EOF
    }

    managed_policy_arns = [
      "arn:aws:iam::aws:policy/AmazonEC2FullAccess"
    ]
  }
}




