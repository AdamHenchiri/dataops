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
  full_account_name      = var.snowflake_full_account
  user              = var.snowflake_user
  password          = var.snowflake_password
}