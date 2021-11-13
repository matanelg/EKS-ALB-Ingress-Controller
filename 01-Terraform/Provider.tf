
# AWS Provider
provider "aws" {
    region = var.AWSregion
}

# We Need TLS Provider For Creating OpenID Connect
terraform {
  required_providers {
    tls = {
      source = "hashicorp/tls"
      version = "3.1.0"
    }
  }
}

provider "tls" {

}

# Resources:
  # OIDC Provider - https://registry.terraform.io/providers/hashicorp/tls/latest/docs
