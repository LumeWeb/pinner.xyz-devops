module "etcd" {
  source = "git::https://github.com/LumeWeb/terraform-modules.git//modules/coordination/etcd?ref=develop"

  name              = "pinner-core-etcd"
  allowed_providers = var.allowed_providers
  root_password     = var.etcd_root_password
  environment       = var.environment

  resources = {
    cpu = {
      cores = 2
    }
    memory = {
      size = 2
      unit = "Gi"
    }
    storage = {
      size = 1
      unit = "Gi"
    }
    persistent_storage = {
      size  = 10
      unit  = "Gi"
      class = "beta3"
    }

    placement_attributes = local.placement_attributes
  }
}