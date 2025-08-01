projectname = "tacbot"
secret_name = "myapp/credentials-v3"
secret_description = "login credential for prod app"
secret_data = {
  username = "admin"
  password = "supersecret123"
}

owned_tags = {
  Environment = "dev"
  Owner       = "chaithu"
  Project     = "tacbot"
}
kms_key_id = "arn:aws:kms:ap-south-1:992382670521:key/222dc8bc-105d-4e03-8001-dcca68a438e5"