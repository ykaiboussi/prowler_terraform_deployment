data "aws_iam_policy_document" "d" {
  statement {
    actions = [
      "cloudwatch:PutMetricData",
      "securityhub:BatchImportFindings",
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents"
    ]

    resources = ["*"]
  }

  statement {
    actions   = ["lambda:InvokeFunction"]
    resources = ["${aws_lambda_function.forwarder.arn}"]
  }

  statement {
    actions = [
      "dynamodb:GetRecords",
      "dynamodb:GetShardIterator",
      "dynamodb:DescribeStream",
      "dynamodb:ListStreams"
    ]

    resources = ["${aws_dynamodb_table.prowler_report.stream_arn}"]
  }
}

resource "aws_iam_policy" "p" {
  name   = "prowler-to-securityHub-policy"
  policy = data.aws_iam_policy_document.d.json
}

data "aws_iam_policy_document" "agent_assume_role_policy" {
  statement {
    actions = [
      "sts:AssumeRole"
    ]
    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }

}

resource "aws_iam_role" "agent" {
  name               = "lambda-role"
  path               = "/"
  assume_role_policy = data.aws_iam_policy_document.agent_assume_role_policy.json
}

resource "aws_iam_role_policy_attachment" "ecs_agent" {
  role       = aws_iam_role.agent.name
  policy_arn = aws_iam_policy.p.arn
}