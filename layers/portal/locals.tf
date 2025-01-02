locals {
  core_state = data.terraform_remote_state.remote_states.outputs
  base_domain = local.core_state.base_domain
  environment = local.core_state.environment
  renterd_base_domain = format("node.%s", local.base_domain)
  placement_attributes = {
    "lumeweb" = true
  }
  s3_endpoint = local.core_state.renterd_s3_endpoint
}
