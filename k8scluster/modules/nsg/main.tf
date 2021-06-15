resource "azurerm_network_security_group" "nsg" {
    count               = length(var.nsgs)
    name                = var.nsgs[count.index]
    location            = var.location
    resource_group_name = var.rgname
    
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
 security_rule {  //Here opened https port
    name                       = "HTTPS"  
    priority                   = 1000  
    direction                  = "Inbound"  
    access                     = "Allow"  
    protocol                   = "Tcp"  
    source_port_range          = "*"  
    destination_port_range     = "443"  
    source_address_prefix      = "*"  
    destination_address_prefix = "*"  
  }  
  security_rule {   //Here opened WinRMport
    name                       = "winrm"  
    priority                   = 1010  
    direction                  = "Inbound"  
    access                     = "Allow"  
    protocol                   = "Tcp"  
    source_port_range          = "*"  
    destination_port_range     = "5985"  
    source_address_prefix      = "*"  
    destination_address_prefix = "*"  
  }  
  security_rule {   //Here opened https port for outbound
    name                       = "winrm-out"  
    priority                   = 100  
    direction                  = "Outbound"  
    access                     = "Allow"  
    protocol                   = "*"  
    source_port_range          = "*"  
    destination_port_range     = "5985"  
    source_address_prefix      = "*"  
    destination_address_prefix = "*"  
  }  
  security_rule {   //Here opened remote desktop port
    name                       = "RDP"  
    priority                   = 110  
    direction                  = "Inbound"  
    access                     = "Allow"  
    protocol                   = "Tcp"  
    source_port_range          = "*"  
    destination_port_range     = "3389"  
    source_address_prefix      = "*"  
    destination_address_prefix = "*"  
  }  
    tags = {
        environment = var.environment
    }
}