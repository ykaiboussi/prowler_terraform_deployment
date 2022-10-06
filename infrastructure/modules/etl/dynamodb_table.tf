# Ingest Prowler report to dynamodb
resource "aws_dynamodb_table" "prowler_report" {
  name             = "prowler-report-table"
  stream_enabled   = var.stream_enabled
  stream_view_type = var.stream_view_type
  read_capacity    = var.read_capacity
  write_capacity   = var.write_capacity
  hash_key         = "TITLE_ID"

  server_side_encryption {
    enabled = true
  }

  attribute {
    name = "TITLE_ID"
    type = "S"
  }
}

resource "aws_lambda_event_source_mapping" "m" {
  batch_size        = 1
  enabled           = true
  event_source_arn  = aws_dynamodb_table.prowler_report.stream_arn
  function_name     = aws_lambda_function.forwarder.function_name
  starting_position = "LATEST"
}