variable "snowflake_organization" {
  description = "Nom de l'organisation Snowflake"
}

variable "snowflake_account" {
  description = "Nom du compte Snowflake"
}

variable "snowflake_user" {
  description = "Utilisateur admin Snowflake"
}

variable "snowflake_password" {
  description = "Mot de passe admin Snowflake"
  sensitive   = true
}

variable "environments" {
  description = "Liste des environnements"
  default     = ["dev", "rec", "prod"]
}