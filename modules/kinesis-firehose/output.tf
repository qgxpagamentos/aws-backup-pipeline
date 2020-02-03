output "firehose_backup_stream_name" {
  value = "${aws_kinesis_firehose_delivery_stream.firehose-backup-pipeline-events-stream.name}"
}
