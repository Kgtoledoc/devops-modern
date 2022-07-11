resource "azurerm_linux_virtual_machine" "apache_vm" {
  name                  = "apache"
  location              = azurerm_resource_group.rg.location
  resource_group_name   = azurerm_resource_group.rg.name
  network_interface_ids = [azurerm_network_interface.ni_apache.id]
  size                  = "Standard_B1ls"
  os_disk {
    name                 = "os_disk_apache"
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }


  computer_name  = "apache"
  admin_username = var.admin_username
  admin_password = var.admin_password



  disable_password_authentication = false

  /*
  disable_password_authentication = true 
  admin_ssh_key {
    username   = "azureuser"
    public_key = tls_private_key.ssh.public_key_openssh
  } */
}
