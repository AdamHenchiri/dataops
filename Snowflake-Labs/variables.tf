variable "environment" {
  description = "Nom de l'environnement (dev, rec, prod)"
  type        = string
}

variable "warehouse_size" {
  description = "Taille du warehouse"
  type        = string
  default     = "X-SMALL"
}

variable "warehouse_auto_suspend" {
  description = "Délai en secondes avant suspension automatique"
  type        = number
  default     = 60
}

variable "user_password" {
  description = "Mot de passe de l'utilisateur"
  type        = string
  sensitive   = true
}
