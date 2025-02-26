locals {
  placement_attributes = {
    "organization" = "Hammer Technologies LLC"
  }

  node_domain = format("node.%s", var.base_domain)
}