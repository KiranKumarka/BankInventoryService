# ============================================================
# resources.tf — Azure Resources
# ============================================================

# ─────────────────────────────────────────────
# Resource Groups (one per environment)
# ─────────────────────────────────────────────
resource "azurerm_resource_group" "rg" {
  for_each = toset(var.environments)

  name     = "rg-${var.app_name}-${each.key}"
  location = var.location

  tags = merge(var.tags, {
    Environment = each.key
  })
}

# ─────────────────────────────────────────────
# App Service Plans (one per environment)
# Each env gets its own plan so SKUs can differ
# ─────────────────────────────────────────────
resource "azurerm_service_plan" "plan" {
  for_each = toset(var.environments)

  name                = "asp-${var.app_name}-${each.key}"
  location            = azurerm_resource_group.rg[each.key].location
  resource_group_name = azurerm_resource_group.rg[each.key].name

  os_type  = "Windows"   # TODO: Change to "Linux" if your app runs on Linux
  sku_name = var.sku_name[each.key]

  tags = merge(var.tags, {
    Environment = each.key
  })
}

# ─────────────────────────────────────────────
# App Services (one per environment)
# ─────────────────────────────────────────────
resource "azurerm_windows_web_app" "app" {
  for_each = toset(var.environments)

  name                = "${var.app_name}-${each.key}"
  location            = azurerm_resource_group.rg[each.key].location
  resource_group_name = azurerm_resource_group.rg[each.key].name
  service_plan_id     = azurerm_service_plan.plan[each.key].id

  # TODO: Switch to azurerm_linux_web_app if using Linux
  site_config {
    application_stack {
      current_stack  = "dotnet"
      dotnet_version = var.dotnet_version
    }

    # Health check — optional but recommended
    # health_check_path = "/health"
  }

  app_settings = {
    "ASPNETCORE_ENVIRONMENT"       = each.key == "prod" ? "Production" : title(each.key)
    "WEBSITE_RUN_FROM_PACKAGE"     = "1"   # Required for Azure DevOps zip deploy

    # TODO: Add your app-specific settings below
    # "ConnectionStrings__DefaultConnection" = var.db_connection_string[each.key]
    # "AzureKeyVault__Url"                   = azurerm_key_vault.kv[each.key].vault_uri
  }

  tags = merge(var.tags, {
    Environment = each.key
  })
} 
