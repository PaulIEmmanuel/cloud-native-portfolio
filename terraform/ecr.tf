resource "aws_ecr_repository" "portfolio_backend" {
  name = "portfolio-backend"

  image_scanning_configuration {
    scan_on_push = true
  }

  image_tag_mutability = "MUTABLE"

  tags = {
    Name        = "portfolio-backend-ecr"
    Environment = "production"
  }
}
