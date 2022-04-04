terraform {
  required_providers {
    vault = {
      source = "hashicorp/vault"
      version = "2.23.0"
    }
  }
}

# Provider config
provider "vault" {
    namespace = "admin"
}


# The locals block contains the logic that will parse my JSON files and create a data structure that is usable 
# for my terraform code
//locals {
  # Take a directory of JSON files, read each one and bring them in to Terraform's native data set
//  var_nocsr = [ for file in fileset(path.module, "../certificates/cert_only/*.json") : jsondecode(file(file)) ]
  # Take that data set and format it so that it can be used with the for_each command by converting it to a map
  # where each top level key is a unique identifier.
  # In this case I am using the common_name key from my example JSON files
//  nocsrmap = {for nocsr in toset(local.var_nocsr): nocsr.common_name => nocsr}
//}

# Gen Cert from customer information. Using info from the 'nocsrmap' var (imported from JSON)
# Certs generated from this resource inherit the CSR info from the 'csrbuiltin' role.
resource "vault_pki_secret_backend_cert" "acmecorp" {

  //backend = vault_mount.acmecorp.path
  //name = vault_pki_secret_backend_role.csrbuiltin.name
  backend = "acmecorp"
  name = "csrbuiltin"
  ttl = 3600

  //for_each = local.nocsrmap
  common_name = var.common_name
  alt_names = [var.alt_names]
  ip_sans = [var.ip_sans]

  auto_renew = true
  min_seconds_remaining = 604800
}

