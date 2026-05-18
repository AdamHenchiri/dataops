output "dev_resources" {
  value = {
    warehouse = module.dev.warehouse_name
    database  = module.dev.database_name
    user      = module.dev.user_name
    role      = module.dev.role_name
  }
}

output "rec_resources" {
  value = {
    warehouse = module.rec.warehouse_name
    database  = module.rec.database_name
    user      = module.rec.user_name
    role      = module.rec.role_name
  }
}

output "prod_resources" {
  value = {
    warehouse = module.prod.warehouse_name
    database  = module.prod.database_name
    user      = module.prod.user_name
    role      = module.prod.role_name
  }
}
