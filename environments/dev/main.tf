locals {
  common_tags = {
    "ManagedBy"   = "Terraform"
    "Owner"       = "TodoMicroAppTeam"
    "Environment" = "dev"
  }
}


module "rg" {
  source      = "../../modules/azurerm_resource_group"
  rg_name     = var.resource_group_name
  rg_location = var.resource_group_location
  rg_tags     = local.common_tags
}

module "acr" {
  depends_on = [module.rg]
  source     = "../../modules/azurerm_container_registry"
  acr_name   = "acrdevtodoapp01"
  rg_name    = var.resource_group_name
  location   = var.resource_group_location
  tags       = local.common_tags
}

module "sql_server" {
  depends_on      = [module.rg]
  source          = "../../modules/azurerm_sql_server"
  sql_server_name = "sql-dev-todoapp-01"
  rg_name         = var.resource_group_name
  location        = var.resource_group_location
  admin_username  = "devopsadmin"
  admin_password  = "P@ssw01rd@123"
  tags            = local.common_tags
}

module "sql_db" {
  depends_on  = [module.sql_server]
  source      = "../../modules/azurerm_sql_database"
  sql_db_name = "sqldb-dev-todoapp"
  server_id   = module.sql_server.server_id
  max_size_gb = "2"
  tags        = local.common_tags
}

module "aks" {
  depends_on = [module.rg]
  source     = "../../modules/azurerm_kubernetes_cluster"
  aks_name   = "aks-dev-todoapp"
  location   = var.resource_group_location
  rg_name    = var.resource_group_name
  dns_prefix = "aks-dev-todoapp"
  tags       = local.common_tags
}


module "pip" {
  depends_on = [module.rg]
  source   = "../../modules/azurerm_public_ip"
  pip_name = "pip-dev-todoapp"
  rg_name  = var.resource_group_name
  location = var.resource_group_location
  sku      = "Standard"
  tags     = local.common_tags
}
