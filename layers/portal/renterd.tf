# Renterd Cluster
module "renterd_cluster" {
  source = "git::https://github.com/LumeWeb/terraform-modules.git//modules/compute/renterd-cluster?ref=develop"

  name = "portal-renterd"

  environment = local.environment
  base_domain = local.renterd_base_domain

  # Authentication
  seed                = var.renterd_seed
  bus_api_password    = var.renterd_api_password
  worker_api_password = var.renterd_api_password

  metrics_enabled = true
  metrics_service_name = "portal-renterd"
  metrics_password = var.metrics_password
  etcd_username = local.core_state.etcd_username
  etcd_password = local.core_state.etcd_password
  etcd_endpoints = [local.core_state.etcd_endpoint]

  enable_s3 = false


  # MySQL Configuration via ProxySQL
  database = {
    type           = "mysql"
    uri = format("%s:%d", module.mysql.provider_host, module.mysql.port)
    password = var.mysql_root_password
  }

  # Resource Configuration
  bus_cpu_cores    = 4
  bus_memory_size  = 8
  bus_storage_size = 200

  autopilot_cpu_cores    = 2
  autopilot_memory_size  = 4

  worker_cpu_cores   = 2
  worker_memory_size = 4
  worker_count       = 1

  allowed_providers = var.allowed_providers
  placement_attributes = local.placement_attributes

  depends_on = [module.mysql]
}