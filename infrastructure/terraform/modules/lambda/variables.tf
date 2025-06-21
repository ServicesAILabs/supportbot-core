variable "function_name" { description = "Name der Lambda-Funktion" }
variable "role_arn" { description = "ARN der IAM Execution Role" }
variable "handler" { description = "Handler-Funktion im Code" }
variable "runtime" { description = "Python Runtime Version" }
variable "s3_bucket" { description = "S3-Bucket mit Lambda-Code" }
variable "s3_key" { description = "S3-Schlüssel für Code-Zip" }
variable "environment" { description = "Umgebung (dev/prod)" }
variable "source_code_hash" {
  description = "SHA256-Hash des Lambda-Codes (base64-codiert)"
  type        = string
}