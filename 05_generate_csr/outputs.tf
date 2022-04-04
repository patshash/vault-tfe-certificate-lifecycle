# Output your new CSR
output "generated_csr" {
  value = tls_cert_request.tfc_csr.cert_request_pem
}

# Store the private key in a sensitive output
output "generated_csr_pkey" {
  value = nonsensitive(tls_private_key.example.private_key_pem) 
  #sensitive = true
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
