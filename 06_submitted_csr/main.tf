terraform {
  required_providers {
    vault = {
      source = "hashicorp/vault"
      version = "3.4.0"
    }
  }
}

# Provider config
provider "vault" {
    namespace = "admin"
}


# The locals block contains the logic that will parse my JSON files and create a data structure that is usable 
# for my terraform code
locals {
  # Take a directory of JSON files, read each one and bring them in to Terraform's native data set
  //var_csr = [ for file in fileset(path.module, "../certificates/submitted_csr/*.json") : jsondecode(file(file)) ]
  # Take that data set and format it so that it can be used with the for_each command by converting it to a map
  # where each top level key is a unique identifier.
  # In this case I am using the common_name key from my example JSON files
  //nocsrmap = {for nocsr in toset(local.var_nocsr): nocsr.common_name => nocsr}
}

# Send CSR for signing. 
resource "vault_pki_secret_backend_sign" "example" {
  //backend = vault_mount.acmecorp.path
  //name = vault_pki_secret_backend_role.acmecorp.name
  backend = "acmecorp"
  name = "prod"

  ttl = 3600

  common_name = var.common_name
  csr = var.csr
}

output "csr_value" {
  value = var.csr
}