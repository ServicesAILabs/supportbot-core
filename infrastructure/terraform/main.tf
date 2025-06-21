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
  source_code_hash = filebase64sha256("C:/Users/Anwender/Desktop/Projects/SUDO_SupportBot/Supportbot-core/lambda_package.zip")
  environment   = var.environment
}

module "ses_support" {
  source             = "./modules/ses"                              #Maybe Bug
  lambda_function_arn = module.email_handler_lambda.function_arn
  // domain             = "supportbot.dev"  # FÜR SPÄTER
  // route53_zone_id    = "Z1234567890ABC" # FÜR SPÄTER
}

resource "aws_ses_active_receipt_rule_set" "main" {
  rule_set_name = module.ses_support.ses_rule_set_name
}

/*
module "ses_support" {
  source             = "./modules/ses"
  domain             = "supportbot.dev" # Ihre Domain hier eintragen
  lambda_function_arn = module.email_handler_lambda.lambda_function_arn
}

# Abhängigkeit herstellen
resource "aws_ses_active_receipt_rule_set" "main" {
  rule_set_name = module.ses_support.ses_rule_set_name
  depends_on    = [module.ses_support]
}
*/