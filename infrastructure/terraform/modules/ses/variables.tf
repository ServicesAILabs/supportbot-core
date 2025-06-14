variable "domain_name" { description = "Domain für SES-Verifizierung" }
variable "recipient_email" { description = "Empfänger-E-Mail-Adresse" }
variable "s3_bucket" { description = "S3-Bucket für E-Mail-Speicherung" }
variable "environment" { description = "Umgebung (dev/prod)" }