terraform {
 required_providers {
   digitalocean = {
     source = "digitalocean/digitalocean"
     version = "1.22.2"
   }
   cloudflare = {
     source = "cloudflare/cloudflare"
     version = "~> 2.0"
   }
 }
}

