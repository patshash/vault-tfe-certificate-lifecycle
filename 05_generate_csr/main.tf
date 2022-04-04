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
  # Import files with CSR information so we can create + sign the CSR
  //var_gencsr = [ for gencsr in fileset (path.module, "../certificates/generate_csr/*.json") : jsondecode(file(gencsr)) ] 
  //gencsrmap = { for gencsr in toset(local.var_gencsr): gencsr.common_name => gencsr }
}

# Create a CSR for signing. Don't create in Vault.
resource "tls_cert_request" "tfc_csr" {
    key_algorithm = "RSA"

    # Uncomment below to provide your own private key.
    #private_key_pem = "${file("private_key.pem")}"
    private_key_pem = tls_private_key.example.private_key_pem
    
    //for_each = local.gencsrmap

    subject {
    common_name = var.common_name
    organization = var.csr_organization
    organizational_unit = var.csr_organizational_unit
    street_address = [var.csr_street_address]
    locality = var.csr_locality
    province = var.csr_province
    country = var.csr_country
    postal_code = var.csr_postal_code
    }
}

# Create a Private Key
resource "tls_private_key" "example" {
  algorithm   = "RSA"
  rsa_bits = "4096"
}

# Send CSR for signing. 
resource "vault_pki_secret_backend_sign" "example" {
  //backend = vault_mount.acmecorp.path
  //name = vault_pki_secret_backend_role.acmecorp.name
  backend = "acmecorp"
  name = "prod"

  ttl = 3600

  //for_each = tls_cert_request.tfc_csr
  //for_each = local.gencsrmap
  common_name = var.common_name
  //common_name = each.value.subject["${each.value.common_name}"].common_name
  csr = tls_cert_request.tfc_csr.cert_request_pem
}
