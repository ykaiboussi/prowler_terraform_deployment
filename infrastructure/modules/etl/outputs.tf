output "dynamodb_table_name" {
  value = aws_dynamodb_table.prowler_report.name
}

output "dynamodb_table_arn" {
  value = aws_dynamodb_table.prowler_report.stream_arn
}