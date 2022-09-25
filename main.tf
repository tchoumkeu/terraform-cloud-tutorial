
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0.2"
    }
  }

  required_version = ">= 1.2.5"
}

provider "azurerm" {
  features {}
}

# create a resource group to hold all our resources
resource "azurerm_resource_group" "todosrg" {
  name     = "todos-app-rg"
  location = "centralus"
}

# create an app service plan in the resource group created above
resource "azurerm_service_plan" "todossp" {
  name                = "todos-service-plan"
  resource_group_name = azurerm_resource_group.todosrg.name
  location            = azurerm_resource_group.todosrg.location
  os_type             = "Linux"
  sku_name            = "S1"
}

# create linux web app in the app service plan
resource "azurerm_linux_web_app" "todosapp" {
  name = "btchoum-todos-web-app"
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
