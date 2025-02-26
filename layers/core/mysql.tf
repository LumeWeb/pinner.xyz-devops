module "mysql" {
  source = "git::https://github.com/LumeWeb/terraform-modules.git//modules/db/mysql?ref=develop"

  name              = "pinner-core-mysql"
  allowed_providers = var.allowed_providers
  root_password     = var.mysql_root_password
  environment       = var.environment
  backups_enabled   =  false

  metrics_enabled = true
  metrics_password = var.metrics_password

  metrics_service_name = "core-mysql"


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
      class = "beta2"
    }
  }

  etcd = {
    endpoints = [module.etcd.service.endpoints[0]]
    username  = var.etcd_root_username
    password  = var.etcd_root_password
  }

  placement_attributes = local.placement_attributes
}