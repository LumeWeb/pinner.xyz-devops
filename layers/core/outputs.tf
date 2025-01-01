output "etcd_endpoint" {
  description = "ETCD service endpoint"
  value = module.etcd.service.endpoints[0]
}

output "etcd_password" {
  description = "ETCD service password"
  value = var.etcd_root_password
  sensitive = true
}

output "etcd_username" {
  description = "ETCD service password"
  value = var.etcd_root_username
  sensitive = true
}


output "mysql_endpoint" {
  description = "MySQL service endpoint"
  value = "${module.mysql.provider_host}:${module.mysql.port}"
}

output "renterd_endpoint" {
  description = "Renterd service endpoint"
  value = module.renterd.dns_fqdn
}

output "renterd_s3_endpoint" {
  description = "Renterd service endpoint"
  value = module.renterd.s3_fqdn
}

output "base_domain" {
  description = "Base domain for DNS records"
  value = var.base_domain
}

output "environment" {
  description = "Deployment environment"
  value = var.environment
}