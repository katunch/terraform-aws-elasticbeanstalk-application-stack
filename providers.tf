provider "aws" {
  region  = var.aws_region
  profile = var.aws_profile
  default_tags {
    tags = {
      "Terraform" = "true"
      "Owner"     = "silas@sobr.ch"
      "jira-key"  = var.jira_key
    }
  }
}