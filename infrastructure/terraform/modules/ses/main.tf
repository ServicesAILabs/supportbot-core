resource "aws_ses_domain_identity" "domain" {
  domain = var.domain_name
}

resource "aws_ses_domain_dkim" "dkim" {
  domain = aws_ses_domain_identity.domain.domain
}

resource "aws_ses_receipt_rule_set" "main" {
  rule_set_name = "supportbot-rule-set-${var.environment}"
}

resource "aws_ses_receipt_rule" "store" {
  name          = "supportbot-store"
  rule_set_name = aws_ses_receipt_rule_set.main.rule_set_name
  recipients    = [var.recipient_email]
  enabled       = true
  scan_enabled  = true

  s3_action {
    position    = 1
    bucket_name = var.s3_bucket
    object_key_prefix = "emails/"
  }
}

resource "aws_ses_active_receipt_rule_set" "main" {
  rule_set_name = aws_ses_receipt_rule_set.main.rule_set_name
}