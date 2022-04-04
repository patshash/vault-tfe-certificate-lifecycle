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

# Create PKI secrets engine
resource "vault_mount" "acmecorp" {
  path = "acmecorp"
  type = "pki"
  default_lease_ttl_seconds = 315360000
  max_lease_ttl_seconds = 315360001
}

# Configure PKI URLs - note these are not used in the demo
resource "vault_pki_secret_backend_config_urls" "acmecorp_config_urls" {
  backend              = vault_mount.acmecorp.path
  #issuing_certificates = ["{$VAULT_ADDR}/v1/pki/ca"]
  #crl_distribution_points = ["{$VAULT_ADDR}/v1/pki/crl"]
  issuing_certificates = ["http://127.0.0.1:8200/v1/pki/ca"]
  crl_distribution_points = ["http://127.0.0.1:8200/v1/pki/crl"]
}

# Create the root cert
resource "vault_pki_secret_backend_root_cert" "acmecorprootca" {
  depends_on = [vault_mount.acmecorp]

  backend = vault_mount.acmecorp.path

  type = "internal"
  common_name = "acmecorp.net"
  ttl = "315360000"
  format = "pem"
  private_key_format = "der"
  key_type = "rsa"
  key_bits = 4096
  exclude_cn_from_sans = true

  # Include some CSR Information in the CA.
  ou = "DevOps"
  organization = "acmeCorp"
}

# Create a role to create certs on your root CA
resource "vault_pki_secret_backend_role" "acmecorp" {
  backend = vault_mount.acmecorp.path
  name    = "prod"
  allowed_domains = ["acmecorp.net"]
  allow_subdomains = true
  allow_ip_sans = true
  
  #max_ttl = "300s"
  generate_lease = true
  key_type = "rsa"
}

# Create a role to create certs from the CA with included CSR info
resource "vault_pki_secret_backend_role" "csrbuiltin" {
  backend = vault_mount.acmecorp.path
  name    = "csrbuiltin"
  allowed_domains = ["acmecorp.net"]
  allow_subdomains = true
  allow_ip_sans = true
  
  #max_ttl = "300s"
  generate_lease = true
  key_type = "rsa"

# CSR information to include on all leaf certs. 
  ou = ["DevOps"]
  organization = ["acmeCorp"]
  country = ["Australia"]
  locality = ["Sydney"]
  street_address = ["123 Welcome St"]
  postal_code = ["2000"]
}