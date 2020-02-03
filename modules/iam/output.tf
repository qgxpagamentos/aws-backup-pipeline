output "role_backup_pipeline_events_firehose_arn" {
  value = "${aws_iam_role.role-backup-pipeline-events-firehose.arn}"
}
output "role_backup_pipeline_events_lambda_arn" {
  value = "${aws_iam_role.role-backup-pipeline-events-lambda.arn}"
}
