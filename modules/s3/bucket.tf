resource "aws_s3_bucket" "backup-pipeline-s3" {
  bucket = "meu.bucket.backup.pipeline"
  acl    = "private"
  region = "${var.region}"
}
