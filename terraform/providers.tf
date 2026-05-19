terraform {
  backend "http" {}

  required_providers {
    snowflake = {
      source  = "snowflakedb/snowflake"
      version = "2.16.0"
    }
  }
}

provider "snowflake" {
  organization_name = split("-", var.snowflake_full_account)[0]
  account_name      = split("-", var.snowflake_full_account)[1]
  user              = var.snowflake_user
  password          = var.snowflake_password
}