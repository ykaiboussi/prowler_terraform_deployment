resource "aws_ecs_cluster" "cluster" {
  name = "prowler-app-${var.environment}"
}