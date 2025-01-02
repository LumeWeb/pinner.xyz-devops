module "prometheus" {
  source = "git::https://github.com/LumeWeb/terraform-modules.git//modules/monitoring/prometheus?ref=develop"
  name   = "prometheus"

  allowed_providers    = var.allowed_providers
  placement_attributes = local.placement_attributes

  persistent_storage = {
    size  = 100
    unit  = "Gi"
    class = "beta3"
  }

  prometheus_admin_password = var.prometheus_admin_password

  aws_access_key_id     = var.aws_access_key_id
  aws_secret_access_key = var.aws_secret_access_key
  s3_bucket             = var.s3_bucket
  s3_endpoint           = var.s3_endpoint
  aws_region            = var.aws_region

  promster_scrape_etcd_url      = local.core_state.etcd_endpoint
  promster_etcd_username = local.etcd_username
  promster_etcd_password = local.core_state.etcd_password


  promster_etcd_base_path = "/discovery/prometheus"
}
