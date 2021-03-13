output "tls_private_key" {
  value = tls_private_key.terraform_demo_ssh_key.private_key_pem
  sensitive = true
}

output "bastion_ip" {
  value = azurerm_public_ip.terraform_demo_public_ip.ip_address
}

output "bastion_fqdn" {
  value = azurerm_dns_a_record.terraform_demo_dns_record.fqdn
}

