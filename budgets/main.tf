# Providers
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region  = "us-east-1"
  profile = "seu profile"
}

resource "aws_budgets_budget" "example" {
  name         = "meu-budget-guilhermelacerda-tf"
  budget_type  = "COST"
  time_unit    = "MONTHLY"
  limit_amount = "10.0"
  limit_unit   = "USD"

  notification {
    threshold_type             = "PERCENTAGE"
    threshold                  = "10"
    comparison_operator        = "GREATER_THAN"
    notification_type          = "ACTUAL"
    subscriber_email_addresses = ["email que vai receber a notificação."]
  }
}
