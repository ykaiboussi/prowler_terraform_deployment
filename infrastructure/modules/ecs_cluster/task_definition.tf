data "template_file" "task_definition" {
  template = file("${path.module}/template/container_definition.tpl")

  vars = {
    aws_region       = var.aws_region
    repository_url   = var.repository_url
    image_version    = var.image_version
    dynamodb_table   = var.dynamodb_table_name
    cloudwatch_group = aws_cloudwatch_log_group.ecs.name
  }
}

resource "aws_ecs_task_definition" "app" {
  family       = "Prowler-2-SecurityHub-Task-${var.environment}"
  network_mode = var.network_mode

  container_definitions = data.template_file.task_definition.rendered
  execution_role_arn    = aws_iam_role.ecs_task_execution_role.arn
  task_role_arn         = aws_iam_role.prowler_saas_role.arn

  requires_compatibilities = var.requires_compatibilities

  cpu    = var.fargate_cpu
  memory = var.memory
}

resource "aws_ecs_service" "main" {
  name            = "prowler-ecs-service-${var.environment}"
  cluster         = aws_ecs_cluster.cluster.name

  launch_type     = var.launch_type
  desired_count   = var.desired_count
  task_definition = aws_ecs_task_definition.app.arn

  network_configuration {
    security_groups  = [aws_security_group.ecs_tasks.id]
    subnets          = var.public_subnets
    assign_public_ip = true
  }
}