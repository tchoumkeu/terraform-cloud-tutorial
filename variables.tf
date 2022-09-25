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
  type        = map(string)
  default = {
    "au"        = "654321"
    "dept"      = "Sales"
    "delete-me" = "asap"
  }
}

variable "sql_admin_login" {
  description = "SQL Server admin user name"
  sensitive   = true
}

variable "sql_admin_password" {
  description = "SQL Server admin password"
  sensitive   = true
}
