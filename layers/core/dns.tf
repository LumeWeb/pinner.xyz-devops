locals {
  renterd_dns_name = replace(module.renterd.dns_fqdn,  format(".%s", var.domain_zone), "")
  renterd_s3_dns_name = replace(module.renterd.s3_fqdn, format(".%s", var.domain_zone), "")
}

resource "cloudns_dns_record" "renterd" {
  name  = local.renterd_dns_name
  zone  = var.domain_zone
  type  = "CNAME"
  value = module.renterd.provider_host
  ttl   = "600"
}

resource "cloudns_dns_record" "renterd_s3" {
  name  = local.renterd_s3_dns_name
  zone  = var.domain_zone
  type  = "CNAME"
  value = module.renterd.provider_host
  ttl   = "600"
}
