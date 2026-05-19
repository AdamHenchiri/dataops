terraform {

  required_providers {
    snowflake = {
      source  = "snowflakedb/snowflake"
      version = "2.16.0"
    }
  }
}

provider "snowflake" {
  organization_name = var.snowflake_organization
  account_name      = var.snowflake_account
  user              = var.snowflake_user
  password          = var.snowflake_password
}