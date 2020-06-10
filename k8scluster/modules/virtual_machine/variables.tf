variable "vmname" {
    type = string
    description = "Name of Virtual Machine"
}
variable "rgname" {
    type = string
    description = "Name of resource group"
}
variable "location" {
    type = string
    description = "Azure location of Virtual Machine"
    default = "eastus"
}
variable "nicids" {
    type = list(string)

}
variable "vmsize" {
    type = string
    default =  "Standard_DS1_v2"
}

variable "saendpoint" {
    type = list(string)
    description = "Storage account Endpoint"

}
variable "environment" {
  type    = string
  default = "Dev"
}
variable "osdiskname" {
  type    = string
 
}
variable "caching" {
  type    = string
  default = "ReadWrite"
}
variable "createoption" {
  type    = string
  default = "FromImage"
}
variable "manageddisktype" {
  type    = string
  default = "Standard_LRS"
}
variable "computername"{
    type = string
}
variable "index"{
    type = number
}