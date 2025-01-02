# Redis
module "redis" {
  source = "git::https://github.com/LumeWeb/terraform-modules.git//modules/db/valkey?ref=develop"

  name = "pinner-portal-redis"

  image = "ghcr.io/lumeweb/akash-valkey:develop"

  resources = {
    cpu = {
      cores = 1
    }
    memory = {
      size = 4
      unit = "Gi"
    }
    storage = {
      size = 1
      unit = "Gi"
    }
    persistent_storage = {
      size = 10
    }
  }

  valkey_config = {
    port             = 6379
    bind             = "0.0.0.0"
    maxmemory        = 0
    maxmemory_policy = "noeviction"
    appendonly       = false
    requirepass      = var.redis_password
  }

  backup_config = {
    enabled = false
  }

  metrics_enabled = true
  metrics_password = var.metrics_password
  etcd_username = local.core_state.etcd_username
  etcd_password = local.core_state.etcd_password
  etcd_endpoints = [local.core_state.etcd_endpoint]

  metrics_service_name = "portal-redis"

  environment          = local.environment
  placement_attributes = local.placement_attributes
  allowed_providers    = var.allowed_providers
  tags = {
    service = "redis"
  }
}
