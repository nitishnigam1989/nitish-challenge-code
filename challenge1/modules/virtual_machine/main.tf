resource "azurerm_resource_group" "rg" {
  name = var.vmRg
  location = var.location
}

resource "azurerm_subnet" "subnet" {
  name                 = var.subnet.name
  resource_group_name  = var.networkRg
  virtual_network_name = var.vnet
  address_prefixes     = var.subnet.address_prefix
}

resource "azurerm_network_interface" "nic" {
    for_each = toset(var.hostnames)
    name = "${each.value}-nic"
    location            = var.location
    resource_group_name = azurerm_resource_group.rg.name
    ip_configuration {
        name                          = "${each.value}-ipconfig"
        subnet_id                     = azurerm_subnet.subnet.id
        private_ip_address_allocation = "Dynamic"
    }
}

resource "azurerm_virtual_machine" "vm" {
    //for_each = toset(var.hostnames)
    for_each              = { for h in var.hostnames : h => [var.zones[index(var.hostnames, h) % length(var.zones)]] }
    name                  = each.key
    location              = var.location
    resource_group_name   = azurerm_resource_group.rg.name
    network_interface_ids = [azurerm_network_interface.nic[each.key].id]
    vm_size               = var.vmSize
    zones                 = each.value
    dynamic "storage_image_reference" {
        for_each = can(var.image) ? { create = true } : {}
        content {
            publisher = var.image.publisher
            offer     = var.image.offer
            sku       = var.image.sku
            version   = var.image.version
        }
    }
    dynamic "storage_data_disk" {
        for_each = can(var.disks) ? var.disks : {}
        content {
            name = format("%s-%s",each.key,storage_data_disk.key)
            create_option = "Attach"
            disk_size_gb = storage_data_disk.value.size
            lun = storage_data_disk.value.lun

        }

    }
    storage_os_disk {
        name              = format("%s-%s",each.key,"osdisk")
        caching           = "ReadWrite"
        create_option     = "FromImage"
        managed_disk_type = "Standard_LRS"
    }
    os_profile {
        computer_name  = each.key
        admin_username = var.adminUsername
        admin_password = var.adminPassword
    }
    os_profile_linux_config {
        disable_password_authentication = false
    }
    delete_os_disk_on_termination = var.delete_os_disk_on_termination
    delete_data_disks_on_termination = var.delete_data_disks_on_termination
    tags = var.tags
}