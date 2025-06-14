module "email_handler_lambda" {
  source      = "../../modules/lambda"
  function_name = "supportbot-email-handler-dev"
  role_arn      = aws_iam_role.lambda_exec.arn
  handler       = "handler.lambda_handler"
  runtime       = "python3.11"
  s3_bucket     = aws_s3_bucket.lambda_code.bucket
  s3_key        = "v1.0.0/lambda_package.zip"
}

module "ses_receiver" {
  source        = "../../modules/ses"
  domain_name   = "supportbot.dev"
  recipient_email = "support@supportbot.dev"
  s3_bucket     = aws_s3_bucket.lambda_code.bucket
}