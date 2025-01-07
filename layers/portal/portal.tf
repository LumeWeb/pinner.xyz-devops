locals {
  portal_instance_count = 1
}
# Portal Node IDs
resource "random_bytes" "uuid_raw" {
  count = local.portal_instance_count

  length = 16
  keepers = {
    instance = count.index
  }
}

data "external" "uuid_formatter" {
  count = local.portal_instance_count

  program = ["python3", "${path.module}/format_uuid.py"]

  query = {
    raw_bytes = random_bytes.uuid_raw[count.index].base64
  }
}

# Portal
module "portal" {
  source = "git::https://github.com/LumeWeb/terraform-modules.git//modules/service/portal?ref=develop"

  count = local.portal_instance_count

  name  = "pinner-portal"
  image = "ghcr.io/lumeweb/akash-portal:standard-latest"

  domain      = local.base_domain
  portal_name = var.portal_name
  port        = var.portal_port
  cluster     = true

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
  }

  mail = {
    host     = var.portal_mail_host
    username = var.portal_mail_username
    password = var.portal_mail_password
    from     = var.portal_mail_from
    ssl      = var.portal_mail_ssl
  }

  storage = {
    s3 = {
      buffer_bucket = var.portal_buffer_bucket
      endpoint      = local.s3_endpoint
      region        = var.portal_buffer_region
      access_key    = var.portal_buffer_access_key
      secret_key    = var.portal_buffer_secret_key
    }
    sia = {
      key     = var.renterd_api_password
      cluster = false
      url     = "http://${module.renterd_cluster.bus.dns_fqdn}"
    }
  }

  database = {
    type            = "mysql"
    host            = module.mysql.provider_host
    port            = module.mysql.port
    username        = "root"
    password        = var.mysql_root_password
    name            = var.mysql_database
    tls             = true
    tls_skip_verify = true
  }

  etcd = {
    endpoints = [local.core_state.etcd_endpoint]
    username = "root"
    password = local.core_state.etcd_password
  }

  redis = {
    address  = module.redis.endpoint
    password = var.redis_password
  }

  metrics_enabled      = true
  metrics_service_name = "portal"
  metrics_password     = var.metrics_password

  environment          = local.environment
  placement_attributes = local.placement_attributes
  allowed_providers    = var.allowed_providers
  extra_env_vars = {
    CLOUDNS_AUTH_ID       = var.cloudns_auth_id
    CLOUDNS_AUTH_PASSWORD = var.cloudns_auth_password
    PORTAL__CORE__NODE_ID = data.external.uuid_formatter[count.index].result.uuid
  }

  ssl_email = var.ssl_email

  caddy_s3_endpoint   = var.caddy_s3_endpoint
  caddy_s3_bucket     = var.caddy_s3_bucket
  caddy_s3_access_key = var.caddy_s3_access_key
  caddy_s3_secret_key = var.caddy_s3_secret_key
}
