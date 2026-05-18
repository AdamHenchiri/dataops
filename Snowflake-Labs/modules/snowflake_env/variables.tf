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
