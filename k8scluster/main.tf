
# Create a resource group if it doesn’t exist
resource "azurerm_resource_group" "rgk8s" {
    name     = "${var.azure_resource_group_name}"
    location = "${var.location}"

    tags = {
        environment = "${var.environment}"
    }
}

# Create virtual network
resource "azurerm_virtual_network" "k8sVNet" {
    name                = "k8sVNet"
    address_space       = ["10.0.0.0/16"]
    location            = "${var.location}"
    resource_group_name = azurerm_resource_group.rgk8s.name

    tags = {
        environment = "${var.environment}"
    }
}

# Create subnet
resource "azurerm_subnet" "k8sSubnet-1" {
    name                 = "k8sSubnet-1"
    resource_group_name  = azurerm_resource_group.rgk8s.name
    virtual_network_name = azurerm_virtual_network.k8sVNet.name
    address_prefix       = "10.0.1.0/24"
}

# Create Static public IPs -1
resource "azurerm_public_ip" "VMPublicIP-1" {
    name                         = "VMPublicIP-1"
    location                     = "${var.location}"
    resource_group_name          = azurerm_resource_group.rgk8s.name
    allocation_method            = "Static"

    tags = {
        environment = "${var.environment}"
    }
}
# Create Static public IPs -2
resource "azurerm_public_ip" "VMPublicIP-2" {
    name                         = "VMPublicIP-2"
    location                     = "${var.location}"
    resource_group_name          = azurerm_resource_group.rgk8s.name
    allocation_method            = "Static"

    tags = {
        environment = "${var.environment}"
    }
}
# Create Static public IPs -3
resource "azurerm_public_ip" "VMPublicIP-3" {
    name                         = "VMPublicIP-3"
    location                     = "${var.location}"
    resource_group_name          = azurerm_resource_group.rgk8s.name
    allocation_method            = "Static"

    tags = {
        environment = "${var.environment}"
    }
}


# Create Network Security Group and rule -1
resource "azurerm_network_security_group" "k8sVNetnsg-1" {
    name                = "k8sVNetnsg-1"
    location            = "${var.location}"
    resource_group_name = azurerm_resource_group.rgk8s.name
    
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

    tags = {
        environment = "${var.environment}"
    }
}
# Create Network Security Group and rule -2
resource "azurerm_network_security_group" "k8sVNetnsg-2" {
    name                = "k8sVNetnsg-2"
    location            = "${var.location}"
    resource_group_name = azurerm_resource_group.rgk8s.name
    
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

    tags = {
        environment = "${var.environment}"
    }
}
# Create Network Security Group and rule -3
resource "azurerm_network_security_group" "k8sVNetnsg-3" {
    name                = "k8sVNetnsg-3"
    location            = "${var.location}"
    resource_group_name = azurerm_resource_group.rgk8s.name
    
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

    tags = {
        environment = "${var.environment}"
    }
}
# Create network interface -1
resource "azurerm_network_interface" "k8sVNetnic-1" {
    name                      = "k8sVNetnic-1"
    location                  = "${var.location}"
    resource_group_name       = azurerm_resource_group.rgk8s.name
    network_security_group_id = azurerm_network_security_group.k8sVNetnsg-1.id

    ip_configuration {
        name                          = "k8sVNetnic-1NicConfiguration"
        subnet_id                     = azurerm_subnet.k8sSubnet-1.id
        private_ip_address_allocation = "Dynamic"
        public_ip_address_id          = azurerm_public_ip.VMPublicIP-1.id
    }

    tags = {
        environment = "${var.environment}"
    }
}
# Create network interface -2
resource "azurerm_network_interface" "k8sVNetnic-2" {
    name                      = "k8sVNetnic-2"
    location                  = "${var.location}"
    resource_group_name       = azurerm_resource_group.rgk8s.name
    network_security_group_id = azurerm_network_security_group.k8sVNetnsg-2.id

    ip_configuration {
        name                          = "k8sVNetnic-2NicConfiguration"
        subnet_id                     = azurerm_subnet.k8sSubnet-1.id
        private_ip_address_allocation = "Dynamic"
        public_ip_address_id          = azurerm_public_ip.VMPublicIP-2.id
    }

    tags = {
        environment = "${var.environment}"
    }
}
# Create network interface -3
resource "azurerm_network_interface" "k8sVNetnic-3" {
    name                      = "k8sVNetnic-3"
    location                  = "${var.location}"
    resource_group_name       = azurerm_resource_group.rgk8s.name
    network_security_group_id = azurerm_network_security_group.k8sVNetnsg-3.id

    ip_configuration {
        name                          = "k8sVNetnic-3NicConfiguration"
        subnet_id                     = azurerm_subnet.k8sSubnet-1.id
        private_ip_address_allocation = "Dynamic"
        public_ip_address_id          = azurerm_public_ip.VMPublicIP-3.id
    }

    tags = {
        environment = "${var.environment}"
    }
}
# Generate random text for a unique storage account name
resource "random_id" "randomId" {
    keepers = {
        # Generate a new ID only when a new resource group is defined
        resource_group = azurerm_resource_group.rgk8s.name
    }
    
    byte_length = 8
}

# Create storage account for boot diagnostics 1
resource "azurerm_storage_account" "k8sstorageaccount-1" {
    name                        = "diag${random_id.randomId.hex}"
    resource_group_name         = azurerm_resource_group.rgk8s.name
    location                    = "${var.location}"
    account_tier                = "Standard"
    account_replication_type    = "LRS"

    tags = {
        environment = "${var.environment}"
    }
}
# Create storage account for boot diagnostics 2
resource "azurerm_storage_account" "k8sstorageaccount-2" {
    name                        = "diag${random_id.randomId.hex}"
    resource_group_name         = azurerm_resource_group.rgk8s.name
    location                    = "${var.location}"
    account_tier                = "Standard"
    account_replication_type    = "LRS"

    tags = {
        environment = "${var.environment}"
    }
}
# Create storage account for boot diagnostics 3
resource "azurerm_storage_account" "k8sstorageaccount-3" {
    name                        = "diag${random_id.randomId.hex}"
    resource_group_name         = azurerm_resource_group.rgk8s.name
    location                    = "${var.location}"
    account_tier                = "Standard"
    account_replication_type    = "LRS"

    tags = {
        environment = "${var.environment}"
    }
}
# Create virtual machine Master Node -1
# key_data ->public ssh key
resource "azurerm_virtual_machine" "masternode-1" {
    name                  = "masternode-1"
    location              = "${var.location}"
    resource_group_name   = azurerm_resource_group.rgk8s.name
    network_interface_ids = [azurerm_network_interface.k8sVNetnic-1.id]
    vm_size               = "Standard_DS1_v2"

    storage_os_disk {
        name              = "masternode-1OsDisk"
        caching           = "ReadWrite"
        create_option     = "FromImage"
        managed_disk_type = "Standard_LRS"
    }

    storage_image_reference {
        publisher = "Canonical"
        offer     = "UbuntuServer"
        sku       = "16.04.0-LTS"
        version   = "latest"
    }

    os_profile {
        computer_name  = "masternode-1vm"
        admin_username = "manasadmin"
        admin_password = "Password1234!"
    }

    os_profile_linux_config {
        disable_password_authentication = false
    }

    boot_diagnostics {
        enabled = "true"
        storage_uri = azurerm_storage_account.k8sstorageaccount-1.primary_blob_endpoint
    }

    tags = {
        environment = "${var.environment}"
    }
}
# Create virtual machine Worker Node -1
# key_data ->public ssh key
resource "azurerm_virtual_machine" "workernode-1" {
    name                  = "workernode-1"
    location              = "${var.location}"
    resource_group_name   = azurerm_resource_group.rgk8s.name
    network_interface_ids = [azurerm_network_interface.k8sVNetnic-2.id]
    vm_size               = "Standard_DS1_v2"

    storage_os_disk {
        name              = "workernode-1OsDisk"
        caching           = "ReadWrite"
        create_option     = "FromImage"
        managed_disk_type = "Standard_LRS"
    }

    storage_image_reference {
        publisher = "Canonical"
        offer     = "UbuntuServer"
        sku       = "16.04.0-LTS"
        version   = "latest"
    }

    os_profile {
        computer_name  = "workernode-1vm"
        admin_username = "manasadmin"
        admin_password = "Password1234!"
    }

    os_profile_linux_config {
        disable_password_authentication = false
    }

    boot_diagnostics {
        enabled = "true"
        storage_uri = azurerm_storage_account.k8sstorageaccount-2.primary_blob_endpoint
    }

    tags = {
        environment = "${var.environment}"
    }
}
# Create virtual machine worker Node -2
# key_data ->public ssh key
resource "azurerm_virtual_machine" "workernode-2" {
    name                  = "workernode-2"
    location              = "${var.location}"
    resource_group_name   = azurerm_resource_group.rgk8s.name
    network_interface_ids = [azurerm_network_interface.k8sVNetnic-3.id]
    vm_size               = "Standard_DS1_v2"

    storage_os_disk {
        name              = "workernode-2OsDisk"
        caching           = "ReadWrite"
        create_option     = "FromImage"
        managed_disk_type = "Standard_LRS"
    }

    storage_image_reference {
        publisher = "Canonical"
        offer     = "UbuntuServer"
        sku       = "16.04.0-LTS"
        version   = "latest"
    }

    os_profile {
        computer_name  = "workernode-2vm"
        admin_username = "manasadmin"
        admin_password = "Password1234!"
    }

    os_profile_linux_config {
        disable_password_authentication = false
    }

    boot_diagnostics {
        enabled = "true"
        storage_uri = azurerm_storage_account.k8sstorageaccount-3.primary_blob_endpoint
    }

    tags = {
        environment = "${var.environment}"
    }
}
