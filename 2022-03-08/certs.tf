resource "tls_private_key" "ca" {
  algorithm   = "RSA"
}

resource "tls_self_signed_cert" "ca" {
  key_algorithm         = "RSA"
  private_key_pem       = tls_private_key.ca.private_key_pem
  is_ca_certificate     = true
  validity_period_hours = 48
  allowed_uses          = [
    "key_encipherment",
    "digital_signature",
    "server_auth",
]

  subject {
    common_name  = "acmapp.tech"
    organization = "ACM"
  }
}


resource "tls_private_key" "cert" {
  algorithm   = "RSA"
}

resource "tls_cert_request" "cert" {
  key_algorithm   = "RSA"
  private_key_pem = tls_private_key.cert.private_key_pem

  dns_names = ["sysadmindemo.acmapp.tech"]

  subject {
    common_name  = "sysadmindemo.acmapp.tech"
    organization = "ACM"
  }
}

resource "tls_locally_signed_cert" "cert" {
  cert_request_pem = tls_cert_request.cert.cert_request_pem

  ca_key_algorithm   = "RSA"
  ca_private_key_pem = tls_private_key.ca.private_key_pem
  ca_cert_pem        = tls_self_signed_cert.ca.cert_pem

  validity_period_hours = "24"
  allowed_uses          = [
    "key_encipherment",
    "digital_signature",
    "server_auth",
  ]
}

