resource "azurerm_resource_group" "terraform_demo_resource_group" {
    name     = "sysadmin-demo"
    location = "eastus"

    tags = local.tags
}

data "azurerm_subnet" "example" {
  name                 = "default"
  virtual_network_name = "acm-general-vnet"
  resource_group_name  = "acm-general"
}

locals {
  owner = "SIGSysAdmin 20210227"
  tags = {environment = "Sysadmin Demo"}
}


resource "azurerm_virtual_network" "terraform_demo_vnet" {
    name                = "sysadmin-demo-vnet"
    address_space       = ["192.168.5.0/24"]
    location            = "eastus"
    resource_group_name = azurerm_resource_group.terraform_demo_resource_group.name

    tags = local.tags
}

resource "azurerm_subnet" "terraform_demo_subnet" {
    name                 = "sysadmin-demo-subnet"
    resource_group_name  = azurerm_resource_group.terraform_demo_resource_group.name
    virtual_network_name = azurerm_virtual_network.terraform_demo_vnet.name
    address_prefixes       = ["192.168.5.0/24"]
}

resource "azurerm_public_ip" "terraform_demo_public_ip" {
    name                         = "demo-bastion-ip"
    location                     = "eastus"
    resource_group_name          = azurerm_resource_group.terraform_demo_resource_group.name
    allocation_method            = "Dynamic"

    tags = local.tags
}

resource "azurerm_network_security_group" "terraform_demo_network_security_group" {
    name                = "sysadmin-demo-nsg"
    location            = "eastus"
    resource_group_name = azurerm_resource_group.terraform_demo_resource_group.name

    security_rule {
        name                       = "SSH"
        priority                   = 1001
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "22"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
    }

    tags = local.tags
}

resource "azurerm_network_interface" "terraform_demo_network_interface_card" {
    name                        = "sysadmin-demo-nic"
    location                    = "eastus"
    resource_group_name         = azurerm_resource_group.terraform_demo_resource_group.name

    ip_configuration {
        name                          = "sysadmin-demo-NicConfiguration"
        subnet_id                     = azurerm_subnet.terraform_demo_subnet.id
        private_ip_address_allocation = "Dynamic"
        public_ip_address_id          = azurerm_public_ip.terraform_demo_public_ip.id
    }

    tags = local.tags
}

resource "azurerm_network_interface_security_group_association" "terraform_demo_sg_nic_link" {
    network_interface_id      = azurerm_network_interface.terraform_demo_network_interface_card.id
    network_security_group_id = azurerm_network_security_group.terraform_demo_network_security_group.id
}


# Boot Diagnostics
resource "random_id" "randomId" {
    keepers = {
        # Generate a new ID only when a new resource group is defined
        resource_group = azurerm_resource_group.terraform_demo_resource_group.name
    }

    byte_length = 8
}

resource "azurerm_storage_account" "terraform_demo_storage_account" {
    name                        = "diag${random_id.randomId.hex}"
    resource_group_name         = azurerm_resource_group.terraform_demo_resource_group.name
    location                    = "eastus"
    account_replication_type    = "LRS"
    account_tier                = "Standard"

    tags = local.tags
}

resource "tls_private_key" "terraform_demo_ssh_key" {
  algorithm = "RSA"
  rsa_bits = 4096
}


resource "azurerm_linux_virtual_machine" "terraform_demo_vm" {
    name                  = "sysadmin-demo-bastion"
    location              = "eastus"
    resource_group_name   = azurerm_resource_group.terraform_demo_resource_group.name
    network_interface_ids = [azurerm_network_interface.terraform_demo_network_interface_card.id]
    size                  = "Standard_A2_v2"

    os_disk {
        name              = "sysadmin-demo-bastion-disk"
        caching           = "ReadWrite"
        storage_account_type = "Standard_LRS"
    }

    source_image_reference {
        publisher = "Canonical"
        offer     = "UbuntuServer"
        sku       = "18.04-LTS"
        version   = "latest"
    }

    computer_name  = "terraformDemo"
    admin_username = "acmadmin"
    disable_password_authentication = true

    admin_ssh_key {
        username       = "acmadmin"
        public_key     = tls_private_key.terraform_demo_ssh_key.public_key_openssh
    }

    boot_diagnostics {
        storage_account_uri = azurerm_storage_account.terraform_demo_storage_account.primary_blob_endpoint
    }

    identity {
        type = "SystemAssigned"
    }

    tags = local.tags
}

data "azurerm_role_definition" "contributor" {
  name = "DNS Zone Contributor"
}

data "azurerm_subscription" "current" {}

resource "azurerm_role_assignment" "terraform_role_assignment" {
  scope              = data.azurerm_subscription.current.id
  role_definition_id = "${data.azurerm_subscription.current.id}${data.azurerm_role_definition.contributor.id}"
  principal_id       = azurerm_linux_virtual_machine.terraform_demo_vm.identity[0].principal_id
}

data "azurerm_dns_zone" "terraform_demo_dns_zone" {
  name                = "acmuic.app"
  resource_group_name = "acm-general"
}

resource "azurerm_dns_a_record" "terraform_demo_dns_record" {
  name                = "terraformdemo"
  zone_name           = data.azurerm_dns_zone.terraform_demo_dns_zone.name
  resource_group_name = data.azurerm_dns_zone.terraform_demo_dns_zone.resource_group_name
  ttl                 = 300
  target_resource_id  = azurerm_public_ip.terraform_demo_public_ip.id
}


