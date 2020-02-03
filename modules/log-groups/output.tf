output "log_group_name" {
  value = "${aws_cloudwatch_log_group.s3_delivery.name}"
}

output "log_stream_name" {
  value = "${aws_cloudwatch_log_stream.s3_delivery.name}"
}
