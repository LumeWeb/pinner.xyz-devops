locals {
  renterd_cluster_bus_dns_name = replace(module.renterd_cluster.bus.dns_fqdn, format(".%s", var.domain_zone), "")
  renterd_cluster_autopilot_dns_name = replace(module.renterd_cluster.autopilot.dns_fqdn, format(".%s", var.domain_zone), "")
}

resource "cloudns_dns_record" "renterd_bus" {
  name  = local.renterd_cluster_bus_dns_name
  zone  = var.domain_zone
  type  = "CNAME"
  value = module.renterd_cluster.bus.host
  ttl   = "600"
}

resource "cloudns_dns_record" "renterd_autopilot" {
  name  =  local.renterd_cluster_autopilot_dns_name
  zone  = var.domain_zone
  type  = "CNAME"
  value = module.renterd_cluster.autopilot.host
  ttl   = "600"
}

resource "cloudns_dns_record" "renterd_workers" {
  count = length(module.renterd_cluster.workers)
  name = replace(module.renterd_cluster.workers[count.index].dns_fqdn, format(".%s", var.domain_zone), "")
  zone  = var.domain_zone
  type  = "CNAME"
  value = module.renterd_cluster.workers[count.index].host
  ttl   = "600"
}