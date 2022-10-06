# Maps Prowler findings sent from ECS to DynamoDB into the ASFF via DynamoDB Streams before importing to Security Hub
resource "aws_lambda_function" "forwarder" {
  filename      = "${path.module}/index.zip"
  function_name = var.function_name
  role          = aws_iam_role.agent.arn
  handler       = var.handler

  source_code_hash = filebase64sha256("${path.module}/index.zip")

  memory_size = var.memory_size
  runtime     = var.runtime

  environment {
    variables = {
      account_num = var.account_num
      region      = var.region
    }
  }
}