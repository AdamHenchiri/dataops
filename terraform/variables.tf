variable "snowflake_full_account" {
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

variable "dev_user_password" {
  description = "Mot de passe USER_DEV"
  type        = string
  sensitive   = true
}

variable "rec_user_password" {
  description = "Mot de passe USER_REC"
  type        = string
  sensitive   = true
}

variable "prod_user_password" {
  description = "Mot de passe USER_PROD"
  type        = string
  sensitive   = true
}