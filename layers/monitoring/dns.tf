locals {
  grafana_dns_name = replace(module.grafana.dns_fqdn,  format(".%s", var.domain_zone), "")
}

resource "cloudns_dns_record" "grafana" {
  name  = local.grafana_dns_name
  zone  = var.domain_zone
  type  = "CNAME"
  value = module.grafana.provider_host
  ttl   = "600"
}