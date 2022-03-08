data "cloudflare_zone" "sysadmindemo" {
  name = "acmapp.tech"
}

resource "cloudflare_record" "sysadmindemo" {
  zone_id = data.cloudflare_zone.sysadmindemo.id
  name    = "sysadmindemo"
  value   = digitalocean_spaces_bucket.sysadmindemo.bucket_domain_name
  type    = "CNAME"
  ttl     = 300
}
