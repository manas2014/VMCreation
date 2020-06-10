
variable "location" {
  type = string
}

variable "nics" {
    type = list(string)
    description = "k8sVNetnic"
    default = ["k8sVNetnic-1","k8sVNetnic-2","k8sVNetnic-3"]
}
variable "ip_configs" {
    type = list(string)
    description = "NicConfiguration"
    default = ["NicConfiguration-1","NicConfiguration-2","NicConfiguration-3"]
}
variable "rgname" {
    type = string
    description = "Name of resource group"
}
variable "nsgids" {
  type = list(string)
}
variable "subnetid" {
  type = string
}
variable "publicips" {
  type = list(string)
}
variable "environment" {
  type = string
}

