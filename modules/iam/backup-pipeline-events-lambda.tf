resource "aws_iam_role" "role-backup-pipeline-events-lambda" {
  name               = "github_role_backup_pipeline_events_lambda"
  description        = "GITHUB - Permite acesso entre lambda para kinesis"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy" "role-backup-pipeline-events-policy-inline" {
  name   = "github_role_backup_pipeline_events_lambda_policy"
  role   = "${aws_iam_role.role-backup-pipeline-events-lambda.id}"
  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "VisualEditor0",
            "Effect": "Allow",
            "Action": "firehose:PutRecord",
            "Resource": "arn:aws:firehose:${var.region}:${var.account_id}:deliverystream/*"
        },
        {
            "Sid": "VisualEditor1",
            "Effect": "Allow",
            "Action": "sqs:ReceiveMessage",
            "Resource": "arn:aws:sqs:*:${var.account_id}:backup-pipeline-events"
        },
        {
            "Sid": "VisualEditor2",
            "Effect": "Allow",
            "Action": [
                "sqs:ListQueues"
            ],
            "Resource": "arn:aws:sqs:*:${var.account_id}:*"
        },
        {
            "Sid": "VisualEditor3",
            "Effect": "Allow",
            "Action": "sqs:DeleteMessage",
            "Resource": "arn:aws:sqs:*:${var.account_id}:backup-pipeline-events"
        },
        {
            "Sid": "VisualEditor4",
            "Effect": "Allow",
            "Action": "sqs:GetQueueAttributes",
            "Resource": "arn:aws:sqs:*:${var.account_id}:backup-pipeline-events"
        },
        {
            "Sid": "VisualEditor5",
            "Effect": "Allow",
            "Action": "logs:*",
            "Resource": "arn:aws:logs:*:*:log-group:*"
        },
        {
            "Sid": "VisualEditor6",
            "Effect": "Allow",
            "Action": "logs:*",
            "Resource": "arn:aws:logs:*:*:log-group:*:log-stream:*"
        }
    ]
}
EOF
}
