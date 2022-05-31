resource "azurerm_resource_group" "main" {
  name     = "${var.rg_name}-${var.env}"
  location = var.rg_location
}
