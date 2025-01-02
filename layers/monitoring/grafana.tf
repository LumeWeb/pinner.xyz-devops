module "grafana" {
  source = "git::https://github.com/LumeWeb/terraform-modules.git//modules/monitoring/grafana?ref=develop"

  admin_password = var.metrics_password
  admin_user     = "admin"

  dns = {
    domain     = format("monitoring.%s", var.base_domain)
    enable_tls = true
  }

  database = {
    host     = module.mysql.provider_host
    port     = module.mysql.port
    username = "root"
    password = var.mysql_root_password
    name     = "grafana"
    type     = "mysql"
    ssl_mode = "skip-verify"
  }

  allowed_providers = var.allowed_providers
  placement_attributes = local.placement_attributes
  pricing_amount = 10000

  cpu_units    = 1
  memory_size  = 1
  memory_unit  = "Gi"
  storage_size = 10
  storage_unit = "Gi"
}