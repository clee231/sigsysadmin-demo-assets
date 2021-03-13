resource "digitalocean_spaces_bucket" "my_bucket" {
  name   = var.bucket_name
  region = "sfo3"
  acl    = "public-read"
}

resource "digitalocean_spaces_bucket_object" "index" {
  region       = digitalocean_spaces_bucket.my_bucket.region
  bucket       = digitalocean_spaces_bucket.my_bucket.name
  key          = "index.html"
  content      = "<html><body><p>Hello World!</p></body></html>"
  content_type = "text/html"
}

#resource "digitalocean_cdn" "my_bucket_cdn" {
#  origin           = digitalocean_spaces_bucket.my_bucket.bucket_domain_name
#  custom_domain    = "${var.subdomain}.${var.domain}"
#}

data "cloudflare_zones" "domain_zone" {
  filter {
    name = var.domain
  }
}

resource "cloudflare_record" "bucket_hostname" {
  zone_id = data.cloudflare_zones.domain_zone.zones[0].id
  name    = var.subdomain
  value   = digitalocean_spaces_bucket.my_bucket.bucket_domain_name
  type    = "CNAME"
  ttl     = 300
}
