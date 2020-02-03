resource "aws_kinesis_firehose_delivery_stream" "firehose-backup-pipeline-events-stream" {
  name        = "github_firehose_backup_pipeline_events_stream"
  destination = "extended_s3"
  
  extended_s3_configuration {
    role_arn   = "${var.role_backup_pipeline_events_firehose_arn}"
    bucket_arn = "${var.bucket_arn}"

    buffer_size        = "10"
    buffer_interval    = "60"
    
    cloudwatch_logging_options {
      enabled         = true
      log_group_name  = "${var.log_group_name}"
      log_stream_name = "${var.log_stream_name}"
    }

  }

}


