variable "clientId" {}
variable "clientSecret" {}
variable "subscriptionId" {}
variable "tenantId" {}
variable "location" {}
variable "vnet" {}
variable "subnet" {}
variable "image" {}
variable "webVm" {}
variable "appVm" {}
variable "dbVm" {}
variable "adminUsername" {
    default = "azureuser"
}
variable "adminPassword" {}
variable "zones" {}