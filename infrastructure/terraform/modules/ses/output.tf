output "domain_identity_arn" {
  value = aws_ses_domain_identity.supportbot.arn
}

output "verification_token" {
  value = aws_ses_domain_identity.supportbot.verification_token
}

output "dkim_tokens" {
  value = aws_ses_domain_dkim.supportbot.dkim_tokens
}

output "ses_rule_set_name" {
  value = aws_ses_receipt_rule_set.main.rule_set_name
}