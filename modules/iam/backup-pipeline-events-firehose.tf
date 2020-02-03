resource "aws_iam_role" "role-backup-pipeline-events-firehose" {
  name               = "github_role_rotate_backup_pipeline_events_firehose"
  description        = "Regras para firehouse backup pipeline"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "firehose.amazonaws.com"
      },
      "Action": "sts:AssumeRole",
      "Condition": {
        "StringEquals": {
          "sts:ExternalId": "${var.account_id}"
        }
      }
    }
  ]
}
EOF
}

resource "aws_iam_role_policy" "role-backup-pipeline-events-firehose-policy-inline" {
  name   = "github_role_backup_pipeline_events_firehose_policy"
  role   = "${aws_iam_role.role-backup-pipeline-events-firehose.id}"
  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "VisualEditor0",
            "Effect": "Allow",
            "Action": "kms:Decrypt",
            "Resource": "arn:aws:kms:*:${var.account_id}:key/%SSE_KEY_ID%",
            "Condition": {
                "StringEquals": {
                    "kms:ViaService": "kinesis.%REGION_NAME%.amazonaws.com"
                }
            }
        },
        {
            "Sid": "VisualEditor1",
            "Effect": "Allow",
            "Action": [
                "glue:GetTableVersion",
                "glue:GetTableVersions",
                "glue:GetTable"
            ],
            "Resource": "*"
        },
        {
            "Sid": "VisualEditor2",
            "Effect": "Allow",
            "Action": [
                "s3:ListBucketMultipartUploads",
                "lambda:InvokeFunction",
                "kinesis:GetShardIterator",
                "lambda:GetFunctionConfiguration",
                "kinesis:DescribeStream",
                "s3:ListBucket",
                "logs:PutLogEvents",
                "kinesis:PutRecord",
                "s3:PutObject",
                "s3:GetObject",
                "s3:AbortMultipartUpload",
                "kinesis:GetRecords",
                "s3:GetBucketLocation"
            ],
            "Resource": [
                "arn:aws:logs:*:${var.account_id}:log-group:${var.log_group_name}:log-stream:*",
                "arn:aws:lambda:*:${var.account_id}:function:%FIREHOSE_DEFAULT_FUNCTION%:%FIREHOSE_DEFAULT_VERSION%",
                "arn:aws:kinesis:*:${var.account_id}:stream/%FIREHOSE_STREAM_NAME%",
                "arn:aws:s3:::${var.backup_pipeline_s3_id}",
                "arn:aws:s3:::${var.backup_pipeline_s3_id}/*",
                "arn:aws:s3:::%FIREHOSE_BUCKET_NAME%",
                "arn:aws:s3:::%FIREHOSE_BUCKET_NAME%/*"
            ]
        }
    ]
}
EOF
}

