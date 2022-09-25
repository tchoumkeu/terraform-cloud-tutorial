variable "location" {
  description = "Azure Location"
  default     = "centralus"
}

variable "app_service_sku" {
  description = "App Service SKU Name"
  default     = "F1"
}

variable "tags" {
  type = map

  default = {
    Environment = terraform.workspace
  }
}