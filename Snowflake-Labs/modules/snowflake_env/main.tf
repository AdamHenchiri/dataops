locals {
  env_upper = upper(var.environment)
}

# ──────────────────────────────────────────────
# WAREHOUSE
# ──────────────────────────────────────────────
resource "snowflake_warehouse" "this" {
  name         = "WH_${local.env_upper}"
  warehouse_size = var.warehouse_size
  auto_suspend = var.warehouse_auto_suspend
  auto_resume  = true

  comment = "Warehouse pour l'environnement ${var.environment}"
}

# ──────────────────────────────────────────────
# DATABASE
# ──────────────────────────────────────────────
resource "snowflake_database" "this" {
  name    = "DB_${local.env_upper}"
  comment = "Database pour l'environnement ${var.environment}"
}

# ──────────────────────────────────────────────
# UTILISATEUR
# ──────────────────────────────────────────────
resource "snowflake_user" "this" {
  name         = "USER_${local.env_upper}"
  login_name   = "user_${var.environment}"
  display_name = "User ${local.env_upper}"
  password     = var.user_password

  default_warehouse = snowflake_warehouse.this.name
  default_role      = snowflake_role.this.name
  default_namespace = snowflake_database.this.name

  must_change_password = "false"

  comment = "Utilisateur pour l'environnement ${var.environment}"
}

# ──────────────────────────────────────────────
# RÔLE
# ──────────────────────────────────────────────
resource "snowflake_role" "this" {
  name    = "ROLE_${local.env_upper}"
  comment = "Rôle pour l'environnement ${var.environment}"
}

# Attribuer le rôle à l'utilisateur
resource "snowflake_grant_role" "to_user" {
  role_name = snowflake_role.this.name
  user_name = snowflake_user.this.name
}

# ──────────────────────────────────────────────
# GRANTS — WAREHOUSE
# ──────────────────────────────────────────────
resource "snowflake_grant_privileges_to_role" "warehouse_usage" {
  role_name  = snowflake_role.this.name
  privileges = ["USAGE"]

  on_account_object {
    object_type = "WAREHOUSE"
    object_name = snowflake_warehouse.this.name
  }
}

# ──────────────────────────────────────────────
# GRANTS — DATABASE
# ──────────────────────────────────────────────
resource "snowflake_grant_privileges_to_role" "database_usage" {
  role_name  = snowflake_role.this.name
  privileges = ["USAGE"]

  on_account_object {
    object_type = "DATABASE"
    object_name = snowflake_database.this.name
  }
}

resource "snowflake_grant_privileges_to_role" "database_create_schema" {
  role_name  = snowflake_role.this.name
  privileges = ["CREATE SCHEMA"]

  on_account_object {
    object_type = "DATABASE"
    object_name = snowflake_database.this.name
  }
}

# Droits sur les schémas futurs
resource "snowflake_grant_privileges_to_role" "future_schema_usage" {
  role_name  = snowflake_role.this.name
  privileges = ["USAGE"]

  on_schema {
    future_schemas_in_database = snowflake_database.this.name
  }
}
