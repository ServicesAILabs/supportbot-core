
# AKTUELLE LÖSUNG MIT ALIAS-E-MAIL (später durch Domain ersetzen)
resource "aws_ses_email_identity" "support" {
  email = "cyborgai.decimal106@passinbox.com"
}

resource "aws_lambda_permission" "allow_ses" {
  statement_id  = "AllowExecutionFromSES"
  action        = "lambda:InvokeFunction"
  function_name = var.lambda_function_arn
  principal     = "ses.amazonaws.com"
}

# Regel-Set für eingehende E-Mails
resource "aws_ses_receipt_rule_set" "main" {
  rule_set_name = "supportbot-inbound-rules"
}

# Regel für Support-E-Mails
resource "aws_ses_receipt_rule" "support_inbound" {
  name          = "support-inbound"
  rule_set_name = aws_ses_receipt_rule_set.main.rule_set_name
  recipients    = ["cyborgai.decimal106@passinbox.com"]  # AKTUELLE E-MAIL
  enabled       = true
  scan_enabled  = true
  
  lambda_action {
    position    = 1
    function_arn = var.lambda_function_arn
    invocation_type = "Event"
  }
}


/*
# SES Domain Identität
resource "aws_ses_domain_identity" "supportbot" {
  domain = var.domain
}

# DKIM Records für bessere E-Mail-Akzeptanz
resource "aws_ses_domain_dkim" "supportbot" {
  domain = aws_ses_domain_identity.supportbot.domain
}

# Regel-Set für eingehende E-Mails
resource "aws_ses_receipt_rule_set" "main" {
  rule_set_name = "supportbot-inbound-rules"
}

# Regel für Support-E-Mails
resource "aws_ses_receipt_rule" "support_inbound" {
  name          = "support-inbound"
  rule_set_name = aws_ses_receipt_rule_set.main.rule_set_name
  recipients    = ["support@${var.domain}"]
  enabled       = true
  scan_enabled  = true
  
  lambda_action {
    position    = 1
    function_arn = var.lambda_function_arn
    invocation_type = "Event"
  }
}

# Berechtigung für SES, Lambda aufzurufen
resource "aws_lambda_permission" "allow_ses" {
  statement_id  = "AllowExecutionFromSES"
  action        = "lambda:InvokeFunction"
  function_name = var.lambda_function_arn
  principal     = "ses.amazonaws.com"
}

# --- DNS AUTOMATION MIT ROUTE 53 ---
data "aws_route53_zone" "selected" {
  zone_id = var.route53_zone_id
}

# TXT Record für Domain-Verifikation
resource "aws_route53_record" "ses_verification" {
  zone_id = var.route53_zone_id
  name    = "_amazonses.${aws_ses_domain_identity.supportbot.domain}"
  type    = "TXT"
  ttl     = "600"
  records = [aws_ses_domain_identity.supportbot.verification_token]
}

# DKIM Records
resource "aws_route53_record" "dkim_records" {
  count   = 3
  zone_id = var.route53_zone_id
  name    = "${element(aws_ses_domain_dkim.supportbot.dkim_tokens, count.index)}._domainkey.${var.domain}"
  type    = "CNAME"
  ttl     = "600"
  records = ["${element(aws_ses_domain_dkim.supportbot.dkim_tokens, count.index)}.dkim.amazonses.com"]
}

# MX Record für E-Mail-Empfang
resource "aws_route53_record" "mx_record" {
  zone_id = var.route53_zone_id
  name    = var.domain
  type    = "MX"
  ttl     = "600"
  records = ["10 inbound-smtp.${data.aws_region.current.name}.amazonaws.com"]
}

# SPF Record für E-Mail-Authentifizierung
resource "aws_route53_record" "spf_record" {
  zone_id = var.route53_zone_id
  name    = var.domain
  type    = "TXT"
  ttl     = "600"
  records = ["v=spf1 include:amazonses.com ~all"]
}

# DMARC Record für E-Mail-Sicherheit
resource "aws_route53_record" "dmarc_record" {
  zone_id = var.route53_zone_id
  name    = "_dmarc.${var.domain}"
  type    = "TXT"
  ttl     = "600"
  records = ["v=DMARC1; p=none; rua=mailto:dmarc-reports@${var.domain}"]
}

# Data source für aktuelle AWS Region
data "aws_region" "current" {}
*/