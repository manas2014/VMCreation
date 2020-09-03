# Create a resource group if it doesn’t exist
module "resource_group" {
  source = "./modules/resource_group"
  rgname = var.rgname
  location = var.location
  environment = var.environment
}


# Create virtual network
module  "vnet" {
    source ="./modules/virtual_network"
    vnetname            = "k8sVNet"
    address_space       = ["10.0.0.0/16"]
    location            = var.location
    rgname              = module.resource_group.name
    environment         = var.environment
}

# Create subnet
module  "subnet" {
    source ="./modules/subnet"
    vnetname            =  module.vnet.name
    address_prefix       = "10.0.1.0/24"
    location            = var.location
    subnetname          = "k8sSubnet-1"
    rgname              = module.resource_group.name
}


# Create Static public IPs
module  "publicip" {
    source ="./modules/public_ip"
    location            = var.location
    allocation_method   = "Static"
    rgname              = module.resource_group.name
    environment         = var.environment
}
# Create Network Security Group and rule -1
module  "nsg" {
    source ="./modules/nsg"
    location            = var.location
    rgname              = module.resource_group.name
    environment         = var.environment
}
# Create network interfaces
module  "nic" {
    source ="./modules/nic"
    location            = var.location
    rgname              = module.resource_group.name
    nsgids              =  module.nsg.ids
    subnetid            =  module.subnet.id
    publicips           =  module.publicip.public_ips
    environment         = var.environment

}

# Create storage account for boot diagnostics
module "storageaccount" {
  source = "./modules/storage_account"
  rgname = module.resource_group.name
  location  = var.location
}
# Create virtual machine Master Node -1
module "master_virtual_machine" {
  source    = "./modules/virtual_machine"

  vmname    = "masternode-1"
  rgname    = module.resource_group.name
  location  = var.location
  index  = 0
  nicids = flatten([module.nic.ids])
  saendpoint = flatten([module.storageaccount.endpoints])
  osdiskname = "masternode-1OsDisk"
  computername = "masternode-1vm"
  publicips = module.publicip.ip_addresses
  filename = "MasterNodeSetupScript.sh"
}
# Create virtual machine Worker Node -1
# key_data ->public ssh key
module "worker1_virtual_machine" {
  source    = "./modules/virtual_machine"

  vmname    = "workernode-1"
  rgname    = module.resource_group.name
  location  = var.location
  index = 1
  nicids = flatten([module.nic.ids])
  saendpoint = flatten([module.storageaccount.endpoints])
  osdiskname = "workernode-1OsDisk"
  computername = "workernode-1vm"
  publicips = module.publicip.ip_addresses
  filename = "WorkerNodeSetupScript.sh"
}
# Create virtual machine worker Node -2
# key_data ->public ssh key
module "worker2_virtual_machine" {
  source    = "./modules/virtual_machine"
  index = 2
  vmname    = "workernode-2"
  rgname    = module.resource_group.name
  location  = var.location
  nicids = flatten([module.nic.ids])
  saendpoint = flatten([module.storageaccount.endpoints])
  osdiskname = "workernode-2OsDisk"
  computername = "workernode-2vm"
  publicips = module.publicip.ip_addresses
  filename = "WorkerNodeSetupScript.sh"
}