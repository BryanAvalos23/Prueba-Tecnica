resource "aws_ecr_repository" "cusca-prueba-tecnica" {
  name                 = var.name_registry
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }

  tags = {
    Name = "${var.project-name}-ecr-repository"
  }
}

resource "aws_ecr_lifecycle_policy" "cusca-prueba-tecnica" {
  repository = aws_ecr_repository.cusca-prueba-tecnica.name
  policy = jsonencode({
    rules = [
      {
        rulePriority = 1
        description  = "Keep the latest 7 versioned images"
        selection = {
          tagStatus      = "tagged"
          tagPatternList = ["v*"]
          countType      = "imageCountMoreThan"
          countNumber    = 7
        }
        action = {
          type = "expire"
        }
      },
      {
        rulePriority = 2
        description  = "Expire untagged images after 7 days"
        selection = {
          tagStatus   = "untagged"
          countType   = "sinceImagePushed"
          countUnit   = "days"
          countNumber = 7
        }
        action = {
          type = "expire"
        }
      }
    ]
  })
}
