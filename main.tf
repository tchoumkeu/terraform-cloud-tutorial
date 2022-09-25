
provider "azurerm" {
  features {}
}

# create a resource group to hold all our resources
resource "azurerm_resource_group" "todosrg" {
  name     = "todos-app-rg-${workspace.name}"
  location = var.location
}

# create an app service plan in the resource group created above
resource "azurerm_service_plan" "todossp" {
  name                = "todos-service-plan-${workspace.name}"
  resource_group_name = azurerm_resource_group.todosrg.name
  location            = azurerm_resource_group.todosrg.location
  os_type             = "Linux"
  sku_name            = var.app_service_sku
}

# create linux web app in the app service plan
resource "azurerm_linux_web_app" "todosapp" {
  name = "btchoum-todos-web-app-${workspace.name}"
  resource_group_name = azurerm_resource_group.todosrg.name
  location = azurerm_resource_group.todosrg.location
  service_plan_id = azurerm_service_plan.todossp.id
  https_only = true

  site_config {
    always_on = false
    minimum_tls_version = "1.2"
    application_stack {
      dotnet_version = "6.0"
    }
  }
}