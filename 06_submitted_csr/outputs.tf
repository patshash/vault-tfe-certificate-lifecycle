# Output your new CSR
output "generated_csr" {
  value = var.csr
}

# Output your certificate
output "generated_csr_cert" {
  value = vault_pki_secret_backend_sign.example.certificate
}

# Output your certificate
output "generated_ca_chain" {
  value = vault_pki_secret_backend_sign.example.ca_chain
}

# Output your certificate
output "generated_cert_expiration" {
  value = vault_pki_secret_backend_sign.example.expiration
}

