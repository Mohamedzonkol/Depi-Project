# Resource group for account 1
resource "azurerm_resource_group" "rg1" {
  provider = azurerm.amr
  name     = "rg1-amr"
  location = "East US"
}

# Resource group for account 2
resource "azurerm_resource_group" "rg2" {
  provider = azurerm.tasneem
  name     = "rg2-tasneem"
  location = "East US"
}
# Resource group for account 3
resource "azurerm_resource_group" "rg3" {
  provider = azurerm.zonkol
  name     = "rg3-zonkol"
  location = "East US"
}

# Virtual Network for account 1
resource "azurerm_virtual_network" "vnet1" {
  provider            = azurerm.amr
  name                = "vnet1"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.rg1.location
  resource_group_name = azurerm_resource_group.rg1.name
}

# Virtual Network for account 2
resource "azurerm_virtual_network" "vnet2" {
  provider            = azurerm.tasneem
  name                = "vnet2"
  address_space       = ["10.1.0.0/16"]
  location            = azurerm_resource_group.rg2.location
  resource_group_name = azurerm_resource_group.rg2.name
}

# Virtual Network for account 3
resource "azurerm_virtual_network" "vnet3" {
  provider            = azurerm.zonkol
  name                = "vnet3"
  address_space       = ["10.1.0.0/16"]
  location            = azurerm_resource_group.rg3.location
  resource_group_name = azurerm_resource_group.rg3.name
}
# Subnet for vnet1
resource "azurerm_subnet" "subnet1" {
  provider            = azurerm.amr
  name                = "subnet1"
  resource_group_name = azurerm_resource_group.rg1.name
  virtual_network_name = azurerm_virtual_network.vnet1.name
  address_prefixes    = ["10.0.1.0/24"]
}

# Subnet for vnet2
resource "azurerm_subnet" "subnet2" {
  provider            = azurerm.tasneem
  name                = "subnet2"
  resource_group_name = azurerm_resource_group.rg2.name
  virtual_network_name = azurerm_virtual_network.vnet2.name
  address_prefixes    = ["10.1.1.0/24"]
}
# Subnet for vnet3
resource "azurerm_subnet" "subnet3" {
  provider            = azurerm.zonkol
  name                = "subnet3"
  resource_group_name = azurerm_resource_group.rg3.name
  virtual_network_name = azurerm_virtual_network.vnet3.name
  address_prefixes    = ["10.1.1.0/24"]
}
# Public IP for account 1
resource "azurerm_public_ip" "my_terraform_public_ip1" {
  provider            = azurerm.amr
  name                = "amrip"
  location            = azurerm_resource_group.rg1.location
  resource_group_name = azurerm_resource_group.rg1.name
  allocation_method   = "Dynamic"
  # allocation_method   = "Static"
  # sku                 = "Standard"
}

# Public IP for account 2
resource "azurerm_public_ip" "my_terraform_public_ip2" {
  provider            = azurerm.tasneem  
  name                = "tasneemip"  
  location            = azurerm_resource_group.rg2.location
  resource_group_name = azurerm_resource_group.rg2.name
  allocation_method   = "Dynamic"

  # allocation_method   = "Static"
  # sku                 = "Standard"
}

# Public IP for account 3
resource "azurerm_public_ip" "my_terraform_public_ip3" {
  provider            = azurerm.zonkol  
  name                = "zonkolip"  
  location            = azurerm_resource_group.rg3.location
  resource_group_name = azurerm_resource_group.rg3.name
  allocation_method   = "Dynamic"

  # allocation_method   = "Static"
  # sku                 = "Standard"
}

# Network Security Group for account 1
resource "azurerm_network_security_group" "my_terraform_nsg1" {
  provider            = azurerm.amr
  name                = "myNetworkSecurityGroup1"
  location            = azurerm_resource_group.rg1.location
  resource_group_name = azurerm_resource_group.rg1.name

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
}

# Network Security Group for account 2
resource "azurerm_network_security_group" "my_terraform_nsg2" {
  provider            = azurerm.tasneem
  name                = "myNetworkSecurityGroup2"
  location            = azurerm_resource_group.rg2.location
  resource_group_name = azurerm_resource_group.rg2.name

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
}
# Network Security Group for account 3
resource "azurerm_network_security_group" "my_terraform_nsg3" {
  provider            = azurerm.zonkol
  name                = "myNetworkSecurityGroup3"
  location            = azurerm_resource_group.rg3.location
  resource_group_name = azurerm_resource_group.rg3.name

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
}


# Network Interface for VM 1
resource "azurerm_network_interface" "nic1" {
  provider            = azurerm.amr
  name                = "nic1"
  location            = "East US"
  resource_group_name = azurerm_resource_group.rg1.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.subnet1.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.my_terraform_public_ip1.id
  }
}

# Network Security Group Association for NIC 1
resource "azurerm_network_interface_security_group_association" "nic1_nsg" {
  provider                = azurerm.amr
  network_interface_id    = azurerm_network_interface.nic1.id
  network_security_group_id = azurerm_network_security_group.my_terraform_nsg1.id
}

# Network Interface for VM 2
resource "azurerm_network_interface" "nic2" {
  provider            = azurerm.tasneem
  name                = "nic2"
  location            = "East US"
  resource_group_name = azurerm_resource_group.rg2.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.subnet2.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.my_terraform_public_ip2.id
  }

}

# Network Security Group Association for NIC 2
resource "azurerm_network_interface_security_group_association" "nic2_nsg" {
  provider                = azurerm.tasneem
  network_interface_id    = azurerm_network_interface.nic2.id
  network_security_group_id = azurerm_network_security_group.my_terraform_nsg2.id
}
# Network Interface for VM 3
resource "azurerm_network_interface" "nic3" {
  provider            = azurerm.zonkol
  name                = "nic3"
  location            = "East US"
  resource_group_name = azurerm_resource_group.rg3.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.subnet3.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.my_terraform_public_ip3.id
  }

}
# Network Security Group Association for NIC 3
resource "azurerm_network_interface_security_group_association" "nic3_nsg" {
  provider                = azurerm.zonkol
  network_interface_id    = azurerm_network_interface.nic3.id
  network_security_group_id = azurerm_network_security_group.my_terraform_nsg3.id
}

# Generate random text for a unique storage account name in Account 1
resource "random_id" "random_id_account1" {
  keepers = {
    resource_group = azurerm_resource_group.rg_account1.name
  }

  byte_length = 8
}

# Generate random text for a unique storage account name in Account 2
resource "random_id" "random_id_account2" {
  keepers = {
    resource_group = azurerm_resource_group.rg_account2.name
  }

  byte_length = 8
}

# Create Storage Account for boot diagnostics in Account 1
resource "azurerm_storage_account" "my_storage_account_account1" {
  provider                     = azurerm.account1
  name                         = "diag${random_id.random_id_account1.hex}"
  location                     = azurerm_resource_group.rg_account1.location
  resource_group_name          = azurerm_resource_group.rg_account1.name
  account_tier                 = "Standard"
  account_replication_type     = "LRS"
}


# Create Storage Account for boot diagnostics in Account 2
resource "azurerm_storage_account" "my_storage_account_account2" {
  provider                     = azurerm.account2
  name                         = "diag${random_id.random_id_account2.hex}"
  location                     = azurerm_resource_group.rg_account2.location
  resource_group_name          = azurerm_resource_group.rg_account2.name
  account_tier                 = "Standard"
  account_replication_type     = "LRS"
}

# VM for account 1
resource "azurerm_linux_virtual_machine" "vm1" {
  provider            = azurerm.amr
  name                = "Master-Node"
  resource_group_name = azurerm_resource_group.rg1.name
  location            = azurerm_resource_group.rg1.location
  size                = "Standard_B2s"


  network_interface_ids = [
    azurerm_network_interface.nic1.id
  ]

   os_disk {
    name                 = "myOsDisk1"
    caching              = "ReadWrite"
    storage_account_type = "Premium_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts-gen2"
    version   = "latest"
  }
    computer_name  = "master-node"
    admin_username ="amr"
    boot_diagnostics {
    storage_account_uri = azurerm_storage_account.my_storage_account_account1.primary_blob_endpoint
  }
}

# VM for account 2
resource "azurerm_linux_virtual_machine" "vm2" {
  provider            = azurerm.tasneem
  name                = "Worker-Node-1"
  resource_group_name = azurerm_resource_group.rg2.name
  location            = azurerm_resource_group.rg2.location
  size                = "Standard_B2s"


  network_interface_ids = [
    azurerm_network_interface.nic2.id
  ]

 os_disk {
    name                 = "myOsDisk2"
    caching              = "ReadWrite"
    storage_account_type = "Premium_LRS"
  }

   source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts-gen2"
    version   = "latest"
  }
  computer_name  = "worker-node-1"
  admin_username = "tasnem"
   boot_diagnostics {
    storage_account_uri = azurerm_storage_account.my_storage_account_account2.primary_blob_endpoint
  }
}
# VM for account 3
resource "azurerm_linux_virtual_machine" "vm3" {
  provider            = azurerm.zonkol
  name                = "Worker-Node-2"
  resource_group_name = azurerm_resource_group.rg3.name
  location            = azurerm_resource_group.rg3.location
  size                = "Standard_B2s"
  network_interface_ids = [
    azurerm_network_interface.nic2.id
  ]

 os_disk {
    name                 = "myOsDisk2"
    caching              = "ReadWrite"
    storage_account_type = "Premium_LRS"
  }

   source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts-gen2"
    version   = "latest"
  }
  computer_name  = "worker-node-2"
  admin_username = "zonkol"
   boot_diagnostics {
    storage_account_uri = azurerm_storage_account.my_storage_account_account2.primary_blob_endpoint
  }
}
