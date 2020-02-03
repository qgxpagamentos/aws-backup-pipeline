resource "aws_lambda_function" "backup-pipeline-events" {
    function_name    = "backup_pipeline_events"
    description      = "Função para enviar dados da fila SQS para Kinesis Firehouse"
    runtime          = "nodejs12.x"
    timeout          = 30
    role             = "${var.role_backup_pipeline_events_lambda_arn}"
    handler          = "index.handler"
    filename         = "${path.module}/backup-pipeline-events/backup-pipeline-events.zip"
    source_code_hash = "${base64sha256(file("${path.module}/backup-pipeline-events/backup-pipeline-events.zip"))}"

    environment {
      variables = {
        REGION               = "${var.region}"
        DELIVERY_STREAM_NAME = "${var.pipeline_stream_name}"
      }
    }
}