variable "location" {
  type =  string
}

variable "rgname" {
    type = string
    description = "Name of resource group"
}
variable "environment" {
  type    = string
  default = "Dev"
}

variable "storage_accounts" {
  type = list(string)
  default = ["samaster1","saworkernode1","saworkernode2"]  
}
