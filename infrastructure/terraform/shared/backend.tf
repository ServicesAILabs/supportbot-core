terraform {
  backend "s3" {
    bucket         = "supportbot-tfstate"  # Muss vorab erstellt werden!
    key            = "global/terraform.tfstate"
    region         = "eu-central-1"
    dynamodb_table = "terraform-locks"     # Muss vorab erstellt werden!
    encrypt        = true
  }
}