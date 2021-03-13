output "tls_private_key" {
  value = tls_private_key.terraform_demo_ssh_key.private_key_pem 
}
