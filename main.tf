provider "azurerm" {
    features {}
}
  
resource "azurerm_resource_group" "my_resource_group" {
    name     = "rg-terraform-is-easy"
    location = "eastus2"
}
