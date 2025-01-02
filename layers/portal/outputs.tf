
output "mysql_endpoint" {
  description = "MySQL service endpoint"
  value = "${module.mysql.provider_host}:${module.mysql.port}"
}

output "renterd_bus_endpoint" {
  description = "Renterd bus endpoint"
  value = module.renterd_cluster.bus.dns_fqdn
}

output "renterd_autopilot_endpoint" {
  description = "Renterd autopilot endpoint"
  value = module.renterd_cluster.autopilot.dns_fqdn
}

output "renterd_workers_endpoints" {
  description = "Renterd workers endpoints"
  value = module.renterd_cluster.workers[*].dns_fqdn
}