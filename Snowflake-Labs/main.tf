terraform {
  required_providers {
    snowflake = {
      source  = "snowflakedb/snowflake"
      version = "2.16.0"
    }
  }
}

provider "snowflake" {
  # Les credentials sont lus depuis les variables d'environnement :
  # SNOWFLAKE_ACCOUNT, SNOWFLAKE_USER, SNOWFLAKE_PASSWORD, SNOWFLAKE_ROLE
}

# ──────────────────────────────────────────────
# DEV
# ──────────────────────────────────────────────
module "dev" {
  source = "./modules/snowflake_env"

  environment            = "dev"
  warehouse_size         = "X-SMALL"
  warehouse_auto_suspend = 60
  user_password          = var.dev_user_password
}

# ──────────────────────────────────────────────
# REC
# ──────────────────────────────────────────────
module "rec" {
  source = "./modules/snowflake_env"

  environment            = "rec"
  warehouse_size         = "X-SMALL"
  warehouse_auto_suspend = 120
  user_password          = var.rec_user_password
}

# ──────────────────────────────────────────────
# PROD
# ──────────────────────────────────────────────
module "prod" {
  source = "./modules/snowflake_env"

  environment            = "prod"
  warehouse_size         = "SMALL"
  warehouse_auto_suspend = 300
  user_password          = var.prod_user_password
}
