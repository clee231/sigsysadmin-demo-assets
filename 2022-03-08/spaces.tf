resource "digitalocean_spaces_bucket" "sysadmindemo" {
  name   = "sysadmindemo"
  region = "nyc3"
  acl    = "public-read"
}

resource "digitalocean_spaces_bucket_object" "index" {
  region       = digitalocean_spaces_bucket.sysadmindemo.region
  bucket       = digitalocean_spaces_bucket.sysadmindemo.name
  key          = "index.html"
  content      = file("assets/index.html")
  content_type = "text/html"
  acl          = "public-read"
}

# openssl req -x509 -nodes -sha256 -days 365 -newkey rsa:4096 -keyout key.pem -out cert.pem
resource "digitalocean_certificate" "cert" {
  name    = "sysadmindemo-cert"
  type    = "custom"
  private_key       = tls_private_key.cert.private_key_pem
  leaf_certificate  = tls_locally_signed_cert.cert.cert_pem
}

resource "digitalocean_cdn" "cdn" {
  origin           = digitalocean_spaces_bucket.sysadmindemo.bucket_domain_name
  custom_domain    = "sysadmindemo.acmapp.tech"
  certificate_name = digitalocean_certificate.cert.name
}
