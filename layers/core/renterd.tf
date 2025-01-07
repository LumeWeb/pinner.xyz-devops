module "renterd" {
  source = "git::https://github.com/LumeWeb/terraform-modules.git//modules/compute/renterd?ref=develop"

  name              = "pinner-core-renterd"

  allowed_providers = var.allowed_providers
  environment       = var.environment

  api_password = var.renterd_api_password
  seed         = var.renterd_seed

  metrics_enabled = true
  metrics_password = var.metrics_password
  etcd_endpoints = [module.etcd.service.endpoints[0]]
  etcd_username = var.etcd_root_username
  etcd_password = var.etcd_root_password

  metrics_service_name = "core-renterd"

  dns = {
    base_domain = local.node_domain
  }

  network = {
    http_port  = 80
    s3_port    = 80
    enable_ssl = false
  }

  database = {
    type     = "mysql"
    uri = format("%s:%d", module.mysql.provider_host, module.mysql.port)
    password = var.mysql_root_password
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
      size = 1
      unit = "Gi"
    }
    persistent_storage = {
      size  = 200
      unit  = "Gi"
      class = "beta3"
    }
  }

  placement_attributes = local.placement_attributes

  depends_on = [module.mysql]
}