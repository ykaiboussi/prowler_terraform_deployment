resource "aws_cloudwatch_log_group" "ecs" {
  name              = "cloudwatch-group-ecs"
  retention_in_days = var.retention_in_days
}

resource "aws_cloudwatch_event_rule" "crn" {
  name                = "prowler-task-scheduler"
  schedule_expression = var.schedule_expression
}

resource "aws_cloudwatch_event_target" "ecs_cluster" {
  arn      = aws_ecs_cluster.cluster.arn
  rule     = aws_cloudwatch_event_rule.crn.name
  role_arn = aws_iam_role.prowler_saas_role.arn

  ecs_target {
    task_count          = var.task_count
    task_definition_arn = aws_ecs_task_definition.app.arn

    launch_type         = var.launch_type
    platform_version    = var.platform_version
    
    network_configuration {
      assign_public_ip = true
      subnets          = var.public_subnets
      security_groups  = [aws_security_group.ecs_tasks.id]
    }
  }
}
