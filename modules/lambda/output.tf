output "lambda_backup_pipeline_events_arn" {
  value = "${aws_lambda_function.backup-pipeline-events.arn}"
}
output "lambda_backup_pipeline_events_function_name" {
  value = "${aws_lambda_function.backup-pipeline-events.function_name}"
}

