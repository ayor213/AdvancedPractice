#Deploy to Azure
terraform {
 required_providers {
  azurerm = {
   source  = "hashicorp/azurerm"
   version = "~> 2.40.0"
  }
 }
}

# Feature for Azure provider (required)
provider "azurerm" {
 features {}
}

# Resource group for our infrastructure
resource "azurerm_resource_group" "mlops_demo_rg" {
 name     = "MLOpsDemo"
 location = "uksouth"
}

resource "azurerm_databricks_workspace" "databricks_workspace_demo"{
    name  = "databricks-demo"
 resource_group_name = azurerm_resource_group.mlops_demo_rg.name
 location = azurerm_resource_group.mlops_demo_rg.location
    sku  = "premium"
}

resource "azurerm_storage_account" "storage_account_demo" {
      name   ="mlopsstorageaccountdemo1"
resource_group_name      = azurerm_resource_group.mlops_demo_rg.name
 location                = azurerm_resource_group.mlops_demo_rg.location
 account_tier              = "Standard"
 account_replication_type  = "LRS"
 allow_blob_public_access  = true
}

resource "azurerm_storage_container" "storage_container_demo" {
  name                  = "mlopsstoragecontainerdemo"
 storage_account_name   = azurerm_storage_account.storage_account_demo.name
 container_access_type  = "blob"
}




