terraform {

  # cloud {
  #   organization = "tchoumkeu-todos"

  #   workspaces {
  #     name = "dev"
  #   }
  # }

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0.2"
    }
  }

  required_version = ">= 1.2.5"
}
