locals {
  # Split domain into parts: ["subdomain", "domain", "tld"] or ["domain", "tld"]
  domain_parts = split(".", var.portal_domain)

  # Get base domain (last 2 parts)
  portal_base_domain = join(".", slice(local.domain_parts, length(local.domain_parts) - 2, length(local.domain_parts)))

  # Get subdomain part (everything except last 2 parts) or empty string
  portal_subdomain = length(local.domain_parts) > 2 ? join(".", slice(local.domain_parts, 0, length(local.domain_parts) - 2)) : ""
}

resource "cloudns_dns_record" "portal" {
  count = length(module.portal)
  name  = local.portal_subdomain
  zone  = local.portal_base_domain
  type  = "A"
  value = module.portal[count.index].ip_address
  ttl   = "600"
}

resource "cloudns_dns_record" "portal_wildcard" {
  count = length(module.portal)
  name  = length(local.portal_subdomain) > 0 ? format("*.%s", local.portal_subdomain) : "*"
  zone  = local.portal_base_domain
  type  = "A"
  value = module.portal[count.index].ip_address
  ttl   = "600"
}