data "aws_iam_policy_document" "prowler_assume_role_policy" {
  statement {
    actions = [
      "sts:AssumeRole"
    ]
    principals {
      type        = "Service"
      identifiers = ["ecs-tasks.amazonaws.com"]
    }
  }

}

data "aws_iam_policy_document" "prowler_role_policy" {
  statement {
    sid    = ""
    actions = [
      "dynamodb:PutItem"
    ]
    resources = [
      "arn:aws:dynamodb:*:*:table/${var.dynamodb_table_name}"
    ]
  }

  statement {
    actions = [
           "account:Get*",
           "appstream:DescribeFleets",
           "ds:Get*",
           "ds:Describe*",
           "ds:List*",
           "ec2:GetEbsEncryptionByDefault",
           "ecr:Describe*",
           "elasticfilesystem:DescribeBackupPolicy",
           "glue:GetConnections",
           "glue:GetSecurityConfiguration",
           "glue:SearchTables",
           "lambda:GetFunction",
           "s3:GetAccountPublicAccessBlock",
           "shield:DescribeProtection",
           "shield:GetSubscriptionState",
           "ssm:GetDocument",
           "support:Describe*",
           "tag:GetTagKeys"
    ]
    resources = ["*"]
  }
}


resource "aws_iam_role" "prowler_saas_role" {
  name                = "prowler-app-agent-${var.environment}"
  assume_role_policy  = data.aws_iam_policy_document.prowler_assume_role_policy.json
  managed_policy_arns = ["arn:aws:iam::aws:policy/SecurityAudit", "arn:aws:iam::aws:policy/job-function/ViewOnlyAccess"]
  inline_policy {
    name   = "prowler-role-additional-view-privileges"
    policy = data.aws_iam_policy_document.prowler_role_policy.json
  }
}