locals {
  portal_dns_name = replace(var.portal_domain, format(".%s", var.domain_zone), "")
}

resource "cloudns_dns_record" "portal" {
  count = length(module.portal)
  name  = local.portal_dns_name
  zone  = var.domain_zone
  type  = "A"
  value = module.portal[count.index].ip_address
  ttl   = "600"
}

resource "cloudns_dns_record" "portal_wildcard" {
  count = length(module.portal)
  name = format("*.%s", local.portal_dns_name)
  zone  = var.domain_zone
  type  = "A"
  value = module.portal[count.index].ip_address
  ttl   = "600"
}