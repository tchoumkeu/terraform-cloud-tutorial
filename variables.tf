variable "location" {
  description = "Azure Location"
  default     = "centralus"
}

variable "app_service_sku" {
  description = "App Service SKU Name"
  default     = "F1"
}

variable "resource_tags" {
  description = "Tags to set for all resources"
  type = map(string)
  default = {
    "au" = "654321"
    "dept" = "Sales"
  }
}
