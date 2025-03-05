terraform {
  backend "s3" {
    skip_credentials_validation = true
    skip_requesting_account_id  = true
    skip_metadata_api_check     = true
    skip_region_validation      = true
    skip_s3_checksum            = true
  }
}

terraform {
  required_providers {
    cloudns = {
      source  = "ClouDNS/cloudns"
      version = "1.0.6"
    }
    akash = {
      source  = "registry.terraform.io/lumeweb/akash"
      version = "0.1.6"
    }
    external = {
      source = "hashicorp/external"
      version = "2.3.4"
    }
    random = {
      source = "hashicorp/random"
      version = "3.6.3"
    }
  }
}

provider "cloudns" {

}

provider "external" {
}

provider "random" {
}

data "terraform_remote_state" "remote_states" {
  backend = "s3"
  config = {
    bucket                      = var.aws_bucket
    key                         = "core/terraform.tfstate"
    skip_credentials_validation = true
    skip_region_validation      = true
    skip_metadata_api_check     = true
    skip_s3_checksum            = true
    use_path_style              = true
  }
}