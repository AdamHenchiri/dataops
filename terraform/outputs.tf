# outputs.tf

output "warehouses" {
  description = "Noms des warehouses créés par environnement"
  value = {
    for env in var.environments :
    env => snowflake_warehouse.env_warehouse[env].name
  }
}

output "databases" {
  description = "Noms des databases créées par environnement"
  value = {
    for env in var.environments :
    env => snowflake_database.env_database[env].name
  }
}

output "roles" {
  description = "Noms des rôles créés par environnement"
  value = {
    for env in var.environments :
    env => snowflake_account_role.env_role[env].name
  }
}

output "users" {
  description = "Noms des utilisateurs créés par environnement"
  value = {
    for env in var.environments :
    env => snowflake_user.env_user[env].name
  }
}

output "dbt_connection_info" {
  description = "Infos de connexion à copier dans ton profiles.yml dbt"
  sensitive   = true
  value = {
    for env in var.environments : env => {
      account   = "${var.snowflake_organization}-${var.snowflake_account}"
      user      = snowflake_user.env_user[env].name
      role      = snowflake_account_role.env_role[env].name
      database  = snowflake_database.env_database[env].name
      warehouse = snowflake_warehouse.env_warehouse[env].name
    }
  }
}