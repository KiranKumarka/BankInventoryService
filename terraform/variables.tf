# ============================================================
# variables.tf — All configurable inputs
# ============================================================

variable "location" {
  description = "Azure region for all resources"
  type        = string
  default     = "East US"
}

variable "app_name" {
  description = "Base name for the application (used in resource naming)"
  type        = string
  default     = "bankinventory"
}

variable "environments" {
  description = "List of environments to create"
  type        = list(string)
  default     = ["dev", "staging", "prod"]
}

variable "sku_name" {
  description = "App Service Plan SKU per environment"
  type        = map(string)
  default = {
    dev     = "B1"   # Basic  — cheap for dev
    staging = "S1"   # Standard — same tier as prod for realistic testing
    prod    = "S1"   # Standard — change to P1v3 for production scale
  }
}

variable "dotnet_version" {
  description = ".NET runtime version"
  type        = string
  default     = "v8.0"   # TODO: Change to match your project's .NET version
}

variable "tags" {
  description = "Common tags applied to all resources"
  type        = map(string)
  default = {
    Project     = "BankInventoryService"
    ManagedBy   = "Terraform"
    Owner       = "DevOps Team"
  }
}
