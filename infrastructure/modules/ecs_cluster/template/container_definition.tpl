[{
  "name": "prowler-app",
  "image": "${repository_url}:${image_version}",
  "environment": [
    {
      "name": "MY_DYANMODB_TABLE",
      "value": "${dynamodb_table}"
    }
  ],
  "logConfiguration": {
    "logDriver": "awslogs",
    "options": {
      "awslogs-group": "${cloudwatch_group}",
      "awslogs-region": "${aws_region}",
      "awslogs-stream-prefix": "ecs"
    }
  }
}]