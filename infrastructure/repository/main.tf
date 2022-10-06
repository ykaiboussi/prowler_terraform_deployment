#The ECR repository we'll push our images to.
resource "aws_ecr_repository" "this" {
  name                 = "prowler_app"
  image_tag_mutability = "MUTABLE"
}
