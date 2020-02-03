output "backup_pipeline_s3_arn" {
  value = "${aws_s3_bucket.backup-pipeline-s3.arn}"
}
output "backup_pipeline_s3_id" {
  value = "${aws_s3_bucket.backup-pipeline-s3.id}"
}
