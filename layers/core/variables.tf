# Infrastructure Config Variables
variable "environment" {
  description = "Deployment environment"
  type        = string
  default     = "prod"
}

variable "base_domain" {
  description = "Base domain for DNS records"
  type        = string
  default     = "pinner.xyz"
}

variable "allowed_providers" {
  description = "List of allowed providers"
  type = list(string)
  default = []
}

variable "domain_zone" {
  description = "ClouDNS zone for DNS records"
  type        = string
  default     = "pinner.xyz"
}

# All sensitive credentials - no defaults
# Database credentials
variable "etcd_root_username" {
  description = "Root username for etcd"
  type        = string
  default     = "root"
  sensitive   = true
}
variable "etcd_root_password" {
  description = "Root password for etcd"
  type        = string
  sensitive   = true
}

variable "mysql_root_password" {
  description = "Root password for MySQL"
  type        = string
  sensitive   = true
}

# Renterd specific
variable "renterd_api_password" {
  description = "API password for Renterd"
  type        = string
  sensitive   = true
}

variable "renterd_seed" {
  description = "Seed for Renterd wallet"
  type        = string
  sensitive   = true
}

# Monitoring
variable "metrics_password" {
  description = "Password for metrics access"
  type        = string
  sensitive   = true
}