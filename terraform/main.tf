# --- WAREHOUSES ---
resource "snowflake_warehouse" "env_warehouse" {
  for_each       = toset(var.environments)
  name           = "WH_${upper(each.key)}"
  warehouse_size = "X-SMALL"
  auto_suspend   = 60
  auto_resume    = true
}

# --- DATABASES ---
resource "snowflake_database" "env_database" {
  for_each = toset(var.environments)
  name     = "DB_${upper(each.key)}"
}

# --- ROLES ---
resource "snowflake_account_role" "env_role" {
  for_each = toset(var.environments)
  name     = "ROLE_${upper(each.key)}"
}

# --- USERS ---
locals {
  user_passwords = {
    dev  = var.dev_user_password
    rec  = var.rec_user_password
    prod = var.prod_user_password
  }
}

resource "snowflake_user" "env_user" {
  for_each          = toset(var.environments)
  name              = "USER_${upper(each.key)}"
  password          = each.key == "dev"  ? var.dev_user_password  :
                      each.key == "rec"  ? var.rec_user_password  :
                      var.prod_user_password 
  default_role      = snowflake_account_role.env_role[each.key].name
  default_warehouse = snowflake_warehouse.env_warehouse[each.key].name
  must_change_password = false
}

# --- Attribution du rôle à l'utilisateur ---
resource "snowflake_grant_account_role" "env_role_grant" {
  for_each  = toset(var.environments)
  role_name = snowflake_account_role.env_role[each.key].name
  user_name = snowflake_user.env_user[each.key].name
}

# --- Droits USAGE sur le warehouse ---
resource "snowflake_grant_privileges_to_account_role" "env_wh_grant" {
  for_each          = toset(var.environments)
  account_role_name = snowflake_account_role.env_role[each.key].name
  privileges        = ["USAGE"]

  on_account_object {
    object_type = "WAREHOUSE"
    object_name = snowflake_warehouse.env_warehouse[each.key].name
  }
}

# --- Droits USAGE sur la database ---
resource "snowflake_grant_privileges_to_account_role" "env_db_grant" {
  for_each          = toset(var.environments)
  account_role_name = snowflake_account_role.env_role[each.key].name
  privileges        = ["USAGE"]

  on_account_object {
    object_type = "DATABASE"
    object_name = snowflake_database.env_database[each.key].name
  }
}

# --- Droit CREATE SCHEMA sur la database ---
resource "snowflake_grant_privileges_to_account_role" "env_schema_grant" {
  for_each          = toset(var.environments)
  account_role_name = snowflake_account_role.env_role[each.key].name
  privileges        = ["CREATE SCHEMA"]

  on_account_object {
    object_type = "DATABASE"
    object_name = snowflake_database.env_database[each.key].name
  }
}