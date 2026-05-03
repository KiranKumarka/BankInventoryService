# 📘 PowerShell Notes — Day 2
> **BankInventoryService — DevOps Learning**
> Language: English + Hindi (Simple Explanation)

---

## 1. Functions (फ़ंक्शन)

**English:** A function is a reusable block of code. Write once, use many times!

**Hindi:** Baar baar same kaam karna ho toh function banao — ek baar likho, jab chahiye tab bulao!

```powershell
function Check-AppStatus {
    param (
        [string]$AppName
    )
    
    $app = Get-AzWebApp | Where-Object { $_.Name -eq $AppName }
    
    if ($app.State -eq "Running") {
        Write-Host "✅ $AppName is Running!" -ForegroundColor Green
    } else {
        Write-Host "❌ $AppName is DOWN!" -ForegroundColor Red
    }
}

# Function use karna (calling)
Check-AppStatus -AppName "bankinventory-dev"
Check-AppStatus -AppName "bankinventory-staging"
Check-AppStatus -AppName "bankinventory-prod"
```

> 💡 `param()` → function ke inputs define karna
> 💡 `[string]` → input ka type — text hoga
> 💡 `-AppName` → parameter naam se value dena

---

## 2. ForEach-Object (पाइप के साथ लूप)

**English:** Like `foreach` but used directly in a pipeline with `|`. Processes each item one by one.

**Hindi:** Pipe ke saath loop — har item pe ek ek karke kaam karo, seedha pipeline mein!

```powershell
# foreach loop (Day 1 wala)
foreach ($env in $environments) {
    Write-Host $env
}

# ForEach-Object — pipe ke saath (Day 2)
Get-AzResourceGroup | ForEach-Object {
    Write-Host $_.ResourceGroupName
}
```

> 💡 `ForEach-Object` = pipe ke saath use hota hai
> 💡 `foreach` = array ke saath use hota hai
> 💡 Dono ka kaam same hai — sirf style alag!

---

## 3. -AsJob (बैकग्राउंड में चलाना)

**English:** Runs a command in the background so you don't have to wait. Multiple tasks run at the same time!

**Hindi:** Kaam background mein chalta rehta hai — tum wait nahi karte! Sab ek saath chalte hain — jaise ek saath 4 log kaam kar rahe hain!

```powershell
# Bina -AsJob → ek ek karke hoga, slow!
Remove-AzResourceGroup -Name "rg1" -Force
Remove-AzResourceGroup -Name "rg2" -Force

# -AsJob ke saath → sab ek saath! Fast! ⚡
Remove-AzResourceGroup -Name "rg1" -Force -AsJob
Remove-AzResourceGroup -Name "rg2" -Force -AsJob
```

> 💡 `-AsJob` → background job start hoti hai
> 💡 Job ka status `State: Running` dikhta hai
> 💡 `Get-Job` → sab background jobs dekhna

---

## 4. -Force (बिना confirmation के)

**English:** Skips the "Are you sure?" confirmation prompt and executes directly.

**Hindi:** "Pakka delete karna hai?" wala sawaal nahi poochha jaata — seedha kaam ho jaata hai!

```powershell
# Bina -Force → confirmation maangega
Remove-AzResourceGroup -Name "rg-test"
# "Are you sure? [Y/N]" aayega

# -Force ke saath → seedha delete!
Remove-AzResourceGroup -Name "rg-test" -Force
```

> ⚠️ `-Force` ke saath careful rehna — undo nahi hota!

---

## 5. Real DevOps Script — Sab Resources Delete Karna

**English:** A script that deletes ALL Azure Resource Groups at once using parallel background jobs.

**Hindi:** Ek script jo saare Azure Resource Groups ek saath background mein delete kar deti hai — fast aur efficient!

```powershell
Get-AzResourceGroup | ForEach-Object {
    Write-Host "Deleting: $($_.ResourceGroupName)..." -ForegroundColor Yellow
    Remove-AzResourceGroup -Name $_.ResourceGroupName -Force -AsJob
}
```

**Output:**
```
Deleting: Test...
Deleting: EuroBank_Group...
Deleting: RG_Eurobank...
Deleting: DefaultResourceGroup-PLC...
```

> 💡 Sab ek saath delete hote hain — parallel!
> 💡 `-AsJob` ki wajah se terminal block nahi hota

---

## 6. Terraform Destroy

**English:** Deletes all Azure resources that were created by Terraform. Safe and tracked!

**Hindi:** Jo kuch Terraform ne banaya tha — woh sab delete kar do! Safe hai kyunki sirf Terraform wale resources jaate hain!

```powershell
cd "path/to/terraform/folder"
terraform destroy
# "yes" type karo jab pooche
```

**Output:**
```
Destroy complete! Resources: 9 destroyed.
```

> 💡 Terraform destroy = Infrastructure ka "undo button"
> 💡 Sirf us subscription ke resources delete hote hain jo terraform.tfvars mein hai
> 💡 Banking mein use hota hai — cost bachane ke liye non-prod environments raat ko destroy karte hain!

---

## 7. Verify Karna — Sab Delete Hua?

**English:** After deletion, always verify that resources are gone.

**Hindi:** Delete karne ke baad confirm karo ki sab gaya!

```powershell
Get-AzResourceGroup | Select-Object ResourceGroupName, Location
# Agar khaali output aaya → Azure clean hai! ✅
```

---

## 📌 Quick Reference — Day 2 Cheat Sheet

| Concept | PowerShell | Matlab |
|---------|-----------|--------|
| Function banana | `function Name { }` | Reusable code block |
| Function parameters | `param([string]$Name)` | Input define karna |
| Function call karna | `FunctionName -Param "value"` | Function use karna |
| Pipe wala loop | `ForEach-Object { }` | Pipeline mein loop |
| Background mein run | `-AsJob` | Parallel execution |
| Confirmation skip | `-Force` | Seedha execute |
| Sab resources delete | `Get-AzResourceGroup \| ForEach-Object { Remove-AzResourceGroup ... }` | Cleanup karna |
| Terraform destroy | `terraform destroy` | IaC cleanup |

---

## 💡 Day 1 vs Day 2 Comparison

| Day 1 | Day 2 |
|-------|-------|
| `foreach` loop | `ForEach-Object` pipe loop |
| Basic commands | Functions banana |
| Resources dekhna | Resources delete karna |
| Sequential | Parallel (-AsJob) |

---

*Day 2 Complete! ✅ — PowerShell Functions + Azure Resource Management + Terraform Destroy*