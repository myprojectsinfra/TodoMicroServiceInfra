terraform {
  backend "azurerm" {
    resource_group_name  = "mybackendrg"
    storage_account_name = "mybackendstoreacc"
    container_name       = "myblobcontainer"
    key                  = "todomicroapp.tfstate"
  }
}