# ============================================================
# terraform.tfvars — Your actual values go here
# ⚠️  Add this file to .gitignore if it contains secrets!
# ============================================================

location    = "polandcentral"       # Change to region closest to you
app_name    = "bankinventory" # Keep lowercase, no spaces

dotnet_version = "v8.0"       # Match your project: v6.0, v7.0, v8.0

# SKUs — B1 is cheapest for dev (paid tier needed for custom domain/SSL)
sku_name = {
  dev     = "B1"
  staging = "S1"
  prod    = "S1"
}

tags = {
  Project   = "BankInventoryService"
  ManagedBy = "Terraform"
  Owner     = "DevOps Team"
} 
