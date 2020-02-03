resource "aws_sqs_queue" "backup-pipeline-failed" {
  name = "backup-pipeline-events-failed"
}

resource "aws_sqs_queue" "backup-pipeline-events" {
  name                      = "backup-pipeline-events"
  redrive_policy            = "{\"deadLetterTargetArn\":\"${aws_sqs_queue.backup-pipeline-failed.arn}\",\"maxReceiveCount\":4}"
}

resource "aws_lambda_event_source_mapping" "backup-pipeline-events-trigger" {
  depends_on       = ["aws_sqs_queue.backup-pipeline-events"]
  event_source_arn = "${aws_sqs_queue.backup-pipeline-events.arn}"
  enabled          = true
  function_name     = "arn:aws:lambda:${var.region}:${var.account_id}:function:backup_pipeline_events"
}