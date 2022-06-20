terraform {
  required_providers {
    azurerm = {
      source  = "azurerm"
      version = "~>2.0"
    }
  }
}
provider "azurerm" {
  subscription_id = "4003bfb0-50d8-45ef-8724-8dcbc93b4370"
  client_id       = "069daab2-9ba1-42e2-b25d-f382a119387c"
  client_secret   = "O8i8Q~5oHEBNkyRLUAO8edEOI6uo2KJbmUhF8b7J"
  tenant_id       = "577fc1d8-0922-458e-87bf-ec4f455eb600"
  features {}
}