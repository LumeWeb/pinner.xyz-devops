locals {
  placement_attributes = {
    "lumeweb" = true
  }

  node_domain = format("node.%s", var.base_domain)
  core_state = data.terraform_remote_state.remote_states.outputs
  etcd_username = "root"
}