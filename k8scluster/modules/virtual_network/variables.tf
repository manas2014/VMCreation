variable "vnetname" {
    type = string
  
}
variable "location" {
  type = string
}
variable "environment" {
  type = string
}
variable "rgname" {
    type = string
    description = "Name of resource group"
}
variable "address_space" {
    type = list(string)
    description = "Name of resource group"
}