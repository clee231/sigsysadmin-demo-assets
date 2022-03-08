terraform {
  required_providers {
    digitalocean = {
      source = "digitalocean/digitalocean"
      version = "2.18.0"
    }
    cloudflare = {
      source = "cloudflare/cloudflare"
      version = "3.9.1"
    }

  }
}

provider "digitalocean" {
  # Configuration options
}

provider "cloudflare" {
  # Configuration options
}


