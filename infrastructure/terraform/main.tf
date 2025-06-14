# Hauptressourcen
resource "aws_s3_bucket" "lambda_code" {
  bucket = "supportbot-lambda-${var.environment}"
}

resource "aws_iam_role" "lambda_exec" {
  name = "supportbot-lambda-role-${var.environment}"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "lambda.amazonaws.com"
      }
    }]
  })
}

resource "aws_iam_role_policy_attachment" "lambda_basic" {
  role       = aws_iam_role.lambda_exec.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

# Modulaufrufe
module "email_handler_lambda" {
  source      = "./modules/lambda"
  function_name = "supportbot-email-handler-${var.environment}"
  role_arn      = aws_iam_role.lambda_exec.arn
  handler       = "handler.lambda_handler"
  runtime       = "python3.11"
  s3_bucket     = aws_s3_bucket.lambda_code.bucket
  s3_key        = "v1.0.0/lambda_package.zip"
  environment   = var.environment
}
