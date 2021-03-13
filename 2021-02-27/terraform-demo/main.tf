resource "azurerm_resource_group" "example" {
  name     = "sysadmin_demo"
  location = "East US"
}

data "azurerm_dns_zone" "example" {
  name                = "acmuic.app"
  resource_group_name = azurerm_resource_group.example.name
}

resource "azurerm_dns_a_record" "example" {
  name                = "devopsftw"
  zone_name           = data.azurerm_dns_zone.example.name
  resource_group_name = azurerm_resource_group.example.name
  ttl                 = 300
  records             = ["1.1.1.1"]
}
