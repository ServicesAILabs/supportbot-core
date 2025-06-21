resource "aws_lambda_function" "function" {
  function_name = var.function_name
  role          = var.role_arn
  handler       = var.handler
  runtime       = var.runtime
  s3_bucket     = var.s3_bucket
  s3_key        = var.s3_key
  source_code_hash = var.source_code_hash
  timeout       = 30 # Sekunden

  dynamic "environment" {
    for_each = var.environment != null ? [1] : []
    content {
      variables = {
        ENVIRONMENT = var.environment
      }
    }
  }
}

resource "aws_cloudwatch_log_group" "lambda_logs" {
  name              = "/aws/lambda/${var.function_name}"
  retention_in_days = 7
}