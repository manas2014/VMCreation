
variable "allocation_method" {
    type = string
    default = "Static"
  
}
variable "location" {
  type = string
}

variable "public_ips" {
    type = list(string)
    description = "public ipts"
    default = ["VMPublicIP-1","VMPublicIP-2","VMPublicIP-3"]
}
variable "rgname" {
    type = string
    description = "Name of resource group"
}
variable "environment" {
  type = string
}