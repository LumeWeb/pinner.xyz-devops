locals {
  placement_attributes = {
    "lumeweb" = true
  }

  node_domain = format("node.%s", var.base_domain)
}