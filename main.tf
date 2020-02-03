terraform {
  backend "s3" {
    bucket                  = "com.XXXXXXXXX.github.terraform.aws"
    key                     = "us-west-2/github-state/terraform.tfstate"
    region                  = "us-west-2"
    shared_credentials_file = ".aws/credentials"
    profile                 = "github-core-prod"
  }
}

provider "aws" {
  region                  = "us-west-2"
  shared_credentials_file = ".aws/credentials"
  profile                 = "github-core-prod"
}

module "s3" {
  source = "./modules/s3"
  region = "${var.region}"
}

module "log-groups" {
  source = "./modules/log-groups"
}

module "iam" {
  source                = "./modules/iam"
  region                = "${var.region}"
  account_id            = "${var.account_id}"
  backup_pipeline_s3_id = "${module.s3.backup_pipeline_s3_id}"
  log_group_name        = "${module.log-groups.log_group_name}"
}

module "kinesis-firehose" {
  source                                   = "./modules/kinesis-firehose"
  log_group_name                           = "${module.log-groups.log_group_name}"
  log_stream_name                          = "${module.log-groups.log_stream_name}"
  bucket_arn                               = "${module.s3.backup_pipeline_s3_arn}"
  role_backup_pipeline_events_firehose_arn = "${module.iam.role_backup_pipeline_events_firehose_arn}"
}

module "lambda" {
  source                                 = "./modules/lambda"
  region                                 = "${var.region}"
  pipeline_stream_name                   = "${module.kinesis-firehose.firehose_backup_stream_name}"
  role_backup_pipeline_events_lambda_arn = "${module.iam.role_backup_pipeline_events_lambda_arn}"
}

module "sqs" {
  source                             = "./modules/sqs"
  region                             = "${var.region}"
  account_id                         = "${var.account_id}"
}

