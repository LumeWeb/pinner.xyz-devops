# Infrastructure Config Variables

variable "base_domain" {
  description = "Base domain for DNS records"
  type        = string
  default     = "pinner.xyz"
}

variable "allowed_providers" {
  description = "List of allowed providers"
  type        = list(string)
  default     = []
}

variable "domain_zone" {
  description = "ClouDNS zone for DNS records"
  type        = string
  default = "pinner.xyz"
}

# All sensitive credentials - no defaults
# Database credentials
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
# Monitoring
variable "admin_password" {
  description = "Password for admin access"
  type        = string
  sensitive   = true
}

variable "metrics_password" {
  description = "Password for metrics access"
  type        = string
  sensitive   = true
}

variable "aws_access_key_id" {
  description = "AWS access key ID"
  type        = string
  sensitive   = true
}

variable "aws_secret_access_key" {
  description = "AWS secret access key"
  type        = string
  sensitive   = true
}

variable "s3_bucket" {
  description = "S3 bucket for backups"
  type        = string
}

variable "aws_bucket" {
  description = "AWS S3 bucket TF state"
  type        = string
}

variable "s3_endpoint" {
  description = "S3 endpoint"
  type        = string
}

variable "aws_region" {
  description = "AWS region"
  type        = string
}

variable "prometheus_admin_password" {
  description = "Prometheus admin password"
  type        = string
  sensitive   = true
}

