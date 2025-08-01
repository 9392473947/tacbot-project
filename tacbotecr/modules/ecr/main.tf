resource "aws_ecr_repository" "this" {
  name = var.name

  encryption_configuration {
    encryption_type = "KMS"
    kms_key         = var.kms_key_arn
  }

  image_tag_mutability = "MUTABLE"

  tags = merge(
    var.owned_tags,
    {
      Name = "${var.projectname}-kms"
    }
  )
}

resource "aws_ecr_lifecycle_policy" "this" {
  count = var.lifecycle_policy != "" ? 1 : 0

  repository = aws_ecr_repository.this.name
  policy     = var.lifecycle_policy
}