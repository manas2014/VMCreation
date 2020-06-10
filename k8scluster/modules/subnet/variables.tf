variable "vnetname" {
    type = string
  
}
variable "subnetname" {
    type = string
  
}
variable "location" {
  type = string
}

variable "address_prefix" {
    type = string
    description = "Name of resource group"
}
variable "rgname" {
    type = string
    description = "Name of resource group"
}