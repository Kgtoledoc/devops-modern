resource "azurerm_virtual_network" "vnet" {
  name                = "vnet_test"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  depends_on = [
    azurerm_resource_group.rg
  ]
}

resource "azurerm_subnet" "subnet" {
  name                 = "subnet_test"
  virtual_network_name = azurerm_virtual_network.vnet.name
  resource_group_name  = azurerm_resource_group.rg.name
  address_prefixes     = ["10.0.1.0/24"]
}

resource "azurerm_public_ip" "ip_public_mysql" {
  name                = "public_ip_mysql"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  allocation_method   = "Dynamic"
}

resource "azurerm_public_ip" "ip_public_apache" {
  name                = "public_ip_apache"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  allocation_method   = "Dynamic"
}

resource "azurerm_network_security_group" "sg_apache" {
  name                = "nsg_apache"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  security_rule {
    access                     = "Allow"
    description                = "Allow SSH"
    destination_address_prefix = "*"
    destination_port_range     = "22"
    direction                  = "Inbound"
    name                       = "SSH"
    priority                   = 1001
    protocol                   = "Tcp"
    source_address_prefix      = "*"
    source_port_range          = "*"
  }
  security_rule {
    access                     = "Allow"
    description                = "Allow HTTP"
    destination_address_prefix = "*"
    destination_port_range     = "80"
    direction                  = "Inbound"
    name                       = "HTTP"
    priority                   = 1002
    protocol                   = "Tcp"
    source_address_prefix      = "*"
    source_port_range          = "*"
  }
}

resource "azurerm_network_security_group" "sg_mysql" {
  name                = "nsg_mysql"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  security_rule {
    access                     = "Allow"
    description                = "Allow SSH"
    destination_address_prefix = "*"
    destination_port_range     = "22"
    direction                  = "Inbound"
    name                       = "SSH"
    priority                   = 1001
    protocol                   = "Tcp"
    source_address_prefix      = "*"
    source_port_range          = "*"
  }
  security_rule {
    access                     = "Allow"
    description                = "Allow MYSQL"
    destination_address_prefix = "*"
    destination_port_range     = "3306"
    direction                  = "Inbound"
    name                       = "MYSQL"
    priority                   = 1002
    protocol                   = "Tcp"
    source_address_prefix      = "*"
    source_port_range          = "*"
  }
}

resource "azurerm_network_interface" "ni_apache" {
  name                = "ni_apache"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "NIC_Apache"
    subnet_id                     = azurerm_subnet.subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.ip_public_apache.id
  }
}

resource "azurerm_network_interface" "ni_mysql" {
  name                = "ni_mysql"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "NIC_Mysql"
    subnet_id                     = azurerm_subnet.subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.ip_public_mysql.id
  }
}

resource "azurerm_network_interface_security_group_association" "mysql" {
  network_interface_id      = azurerm_network_interface.ni_mysql.id
  network_security_group_id = azurerm_network_security_group.sg_mysql.id
}

resource "azurerm_network_interface_security_group_association" "apache" {
  network_interface_id      = azurerm_network_interface.ni_apache.id
  network_security_group_id = azurerm_network_security_group.sg_apache.id
}