
provider "azurerm" {
  features {}
}

# create a resource group to hold all our resources
resource "azurerm_resource_group" "todosrg" {
  name     = "todos-app-rg-${terraform.workspace}"
  location = var.location
  tags     = merge(var.resource_tags, { env = terraform.workspace })
}

# create an app service plan in the resource group created above
resource "azurerm_service_plan" "todossp" {
  name                = "todos-service-plan-${terraform.workspace}"
  resource_group_name = azurerm_resource_group.todosrg.name
  location            = azurerm_resource_group.todosrg.location
  os_type             = "Linux"
  sku_name            = var.app_service_sku
  tags                = merge(var.resource_tags, { type = "web", env = terraform.workspace })
}

# create linux web app in the app service plan
resource "azurerm_linux_web_app" "todosapp" {
  name                = "btchoum-todos-web-app-${terraform.workspace}"
  resource_group_name = azurerm_resource_group.todosrg.name
  location            = azurerm_resource_group.todosrg.location
  service_plan_id     = azurerm_service_plan.todossp.id
  tags                = merge(var.resource_tags, { type = "web", env = terraform.workspace })
  https_only          = true

  site_config {
    always_on           = false
    minimum_tls_version = "1.2"
    application_stack {
      dotnet_version = "6.0"
    }
  }
}

# Create SQL Server database
resource "azurerm_mssql_server" "todosmssqlserver" {
  name                = "btchoum-todos-mssql-server-${terraform.workspace}"
  resource_group_name = azurerm_resource_group.todosrg.name
  location            = azurerm_resource_group.todosrg.location
  version             = "12.0"
  minimum_tls_version = "1.2"
  tags                = merge(var.resource_tags, { type = "sql-server", env = terraform.workspace })

  azuread_administrator {
    login_username              = "user_123"
    object_id                   = "00000000-0000-0000-0000-000000000000"
    azuread_authentication_only = true
  }
}
