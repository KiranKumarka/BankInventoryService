# 🏗️ BankInventoryService — Terraform Setup Guide

## 📁 File Structure
```
terraform/
├── main.tf          # Provider + backend config
├── variables.tf     # All input variables
├── resources.tf     # Azure resources (RG, App Service Plan, App Service)
├── outputs.tf       # Outputs shown after apply
└── terraform.tfvars # Your actual values (don't commit secrets!)
```

---

## ⚡ Quick Start (Local)

### Step 1 — Install Terraform
```bash
# Windows (winget)
winget install HashiCorp.Terraform

# Or download from: https://developer.hashicorp.com/terraform/downloads
```

### Step 2 — Login to Azure CLI
```bash
az login
az account set --subscription "YOUR_SUBSCRIPTION_ID"
```

### Step 3 — Initialize Terraform
```bash
cd terraform/
terraform init
```

### Step 4 — Preview what will be created
```bash
terraform plan
```

### Step 5 — Create the Azure resources
```bash
terraform apply
# Type 'yes' when prompted
```

### Step 6 — Copy outputs to azure-pipelines.yml
After apply, you'll see output like:
```
app_service_names = {
  dev     = "bankinventory-dev"
  staging = "bankinventory-staging"
  prod    = "bankinventory-prod"
}
app_service_urls = {
  dev     = "https://bankinventory-dev.azurewebsites.net"
  staging = "https://bankinventory-staging.azurewebsites.net"
  prod    = "https://bankinventory-prod.azurewebsites.net"
}
```
Copy these names into `azure-pipelines.yml` variables section!

---

## 🔒 Step 7 — Create Service Connection in Azure DevOps
1. Go to **Azure DevOps → Project Settings → Service Connections**
2. Click **New Service Connection → Azure Resource Manager**
3. Choose **Service Principal (automatic)**
4. Select your Subscription
5. Give it a name e.g. `azure-bankinventory-sc`
6. Copy this name into `azure-pipelines.yml`:
   ```yaml
   azureSubscription: 'azure-bankinventory-sc'
   ```

---

## ✅ Checklist after terraform apply

- [ ] 3 Resource Groups created (dev, staging, prod)
- [ ] 3 App Service Plans created
- [ ] 3 App Services created
- [ ] App Service names copied to azure-pipelines.yml
- [ ] Service Connection created in Azure DevOps
- [ ] Deploy tasks uncommented in azure-pipelines.yml
- [ ] Environments created in Azure DevOps (Dev, Staging, Prod)
- [ ] Approval gates set on Staging and Prod environments

---

## 🗑️ To destroy all resources (save cost)
```bash
terraform destroy 
```
