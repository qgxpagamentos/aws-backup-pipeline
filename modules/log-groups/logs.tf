resource "aws_cloudwatch_log_group" "s3_delivery" {
  name = "/aws/kinesis_firehose/backup-pipeline-events-stream"
}

resource "aws_cloudwatch_log_stream" "s3_delivery" {
  name           = "s3-delivery"
  log_group_name = "${aws_cloudwatch_log_group.s3_delivery.name}"
}