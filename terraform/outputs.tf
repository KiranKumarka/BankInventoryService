# ============================================================
# outputs.tf — Values shown after terraform apply
#              Copy these into your azure-pipelines.yml
# ============================================================

output "app_service_names" {
  description = "App Service names — paste these into azure-pipelines.yml variables"
  value = {
    for env in var.environments :
    env => azurerm_windows_web_app.app[env].name
  }
}

output "app_service_urls" {
  description = "Live URLs for each environment"
  value = {
    for env in var.environments :
    env => "https://${azurerm_windows_web_app.app[env].default_hostname}"
  }
}

output "resource_group_names" {
  description = "Resource group names per environment"
  value = {
    for env in var.environments :
    env => azurerm_resource_group.rg[env].name
  }
} 
