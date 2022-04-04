# Output the new certificate
output "cert_only" {
  value = vault_pki_secret_backend_cert.acmecorp.certificate
}

# Store the private key in as sensitive output 
output "cert_only_pkey" {
  value =  vault_pki_secret_backend_cert.acmecorp.private_key
  sensitive = false
}
