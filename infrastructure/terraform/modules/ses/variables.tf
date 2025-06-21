variable "domain" {
  description = "Domain für SES (muss verifiziert werden)"
  type        = string
}

variable "lambda_function_arn" {
  description = "ARN der Lambda-Funktion für Verarbeitung"
  type        = string
}

variable "route53_zone_id" {
  description = "ID der Route 53 Hosted Zone für die Domain"
  type        = string
}

variable "domain_name" { description = "Domain für SES-Verifizierung" }
variable "recipient_email" { description = "Empfänger-E-Mail-Adresse" }
variable "s3_bucket" { description = "S3-Bucket für E-Mail-Speicherung" }
variable "environment" { description = "Umgebung (dev/prod)" }