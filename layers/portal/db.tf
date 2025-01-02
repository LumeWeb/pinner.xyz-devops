# MySQL

module "mysql" {
  source = "git::https://github.com/LumeWeb/terraform-modules.git//modules/db/mysql?ref=develop"

  name              = "pinner-portal-mysql"

  root_password     = var.mysql_root_password
  environment  = local.environment
  backups_enabled   =  false

  metrics_enabled = true
  metrics_password = var.metrics_password
  metrics_service_name = "portal-mysql"

  etcd = {
    endpoints = [local.core_state.etcd_endpoint]
    username  = local.core_state.etcd_username
    password  = local.core_state.etcd_password
  }


  resources = {
    cpu = {
      cores = 4
    }
    memory = {
      size = 8
      unit = "Gi"
    }
    storage = {
      size = 10
      unit = "Gi"
    }
    persistent_storage = {
      size  = 100
      unit  = "Gi"
      class = "beta3"
    }
  }

  allowed_providers = var.allowed_providers
  placement_attributes = local.placement_attributes
}