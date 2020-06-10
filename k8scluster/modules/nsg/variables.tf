variable "location" {
  type = string
}

variable "nsgs" {
    type = list(string)
    description = "k8sVNetnsg"
    default = ["k8sVNetnsg-1","k8sVNetnsg-2","k8sVNetnsg-3"]
}
variable "rgname" {
    type = string
    description = "Name of resource group"
}
variable "environment" {
  type = string
}