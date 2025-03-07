locals {
  placement_attributes = {
    "organization" = "Hammer Technologies LLC"
  }

  node_domain = format("node.%s", var.base_domain)
  core_state = data.terraform_remote_state.remote_states.outputs
  etcd_username = "root"
  environment = local.core_state.environment
}