resource "azurerm_virtual_network" "vn" {
  name                = "virtual_network"
  address_space       = ["10.0.0.0/16"]
  location            = azure_resource_group.rg.location
  resource_group_name = azure_resource_group.rg.name
}