provider "azurerm" {
  client_id       = var.clientId
  client_secret   = var.clientSecret
  tenant_id       = var.tenantId
  subscription_id = var.subscriptionId
  features {}
}