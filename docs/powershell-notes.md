# 📘 PowerShell Notes — Day 1
> **BankInventoryService — DevOps Learning**
> Language: English + Hindi (Simple Explanation)

---

## 1. Variables (वेरिएबल)

**English:** A variable stores a value. In PowerShell, variables start with `$`.

**Hindi:** Variable ek dabba hai jisme koi bhi value rakh sakte hain. PowerShell mein `$` se shuru hota hai.

```powershell
$name = "BankInventory"
Write-Host "Hello $name!"
# Output: Hello BankInventory!
```

---

## 2. Conditions — if / elseif / else (शर्त)

**English:** Used to make decisions based on a condition.

**Hindi:** Agar yeh sahi hai toh yeh karo, warna kuch aur karo.

```powershell
$environment = "Dev"

if ($environment -eq "Dev") {
    Write-Host "Yeh Development environment hai!"
} elseif ($environment -eq "Prod") {
    Write-Host "Yeh Production environment hai!"
} else {
    Write-Host "Unknown environment!"
}
# Output: Yeh Development environment hai!
```

> 💡 `-eq` matlab **equal to** (== jaisa hota hai doosri languages mein)

---

## 3. Arrays (ऐरे)

**English:** An array holds multiple values in one variable.

**Hindi:** Ek variable mein kai saari values rakh sakte hain — jaise ek list!

```powershell
$environments = @("Dev", "Staging", "Prod")
```

> 💡 `@()` matlab — yeh ek array hai

---

## 4. Loops — foreach (लूप)

**English:** Used to repeat an action for each item in a list.

**Hindi:** List ki har cheez pe ek ek karke kaam karo.

```powershell
$environments = @("Dev", "Staging", "Prod")

foreach ($env in $environments) {
    Write-Host "Deploying to $env environment..."
}
# Output:
# Deploying to Dev environment...
# Deploying to Staging environment...
# Deploying to Prod environment...
```

---

## 5. Pipe — | (पाइप)

**English:** Pipe passes the output of one command as input to the next command.

**Hindi:** Ek command ka result seedha doosri command ko de do — jaise paani ka pipe! 🚰

```powershell
Get-AzResourceGroup | Select-Object ResourceGroupName, Location
```

> 💡 `Get-AzResourceGroup` → saare groups laao
> 💡 `Select-Object` → sirf yeh columns dikhao

---

## 6. Filtering — Where-Object + $_ (फ़िल्टर)

**English:** Filter results based on a condition. `$_` refers to the current item being processed.

**Hindi:** Sirf wahi results dikhao jo tumhe chahiye. `$_` matlab — abhi jo item process ho raha hai woh.

```powershell
Get-AzResourceGroup | Where-Object { $_.ResourceGroupName -like "*bankinventory*" } | Select-Object ResourceGroupName, Location
```

> 💡 `-like "*bankinventory*"` → jisme bhi "bankinventory" ho woh dikhao
> 💡 `*` matlab — kuch bhi ho pehle ya baad mein

---

## 7. Azure Commands (Azure कमांड्स)

**English:** PowerShell commands to manage Azure resources.

**Hindi:** Azure ki cheezein PowerShell se dekhna aur manage karna.

```powershell
# Saare Resource Groups dekhna
Get-AzResourceGroup | Select-Object ResourceGroupName, Location

# Saare App Services dekhna
Get-AzWebApp | Select-Object Name, ResourceGroup, State

# Sirf BankInventory ke App Services filter karna
Get-AzWebApp | Where-Object { $_.Name -like "*bankinventory*" } | Select-Object Name, ResourceGroup, State
```

---

## 8. Real DevOps Script — Health Check ✅

**English:** A script that checks if all App Services are running and shows colored output.

**Hindi:** Ek script jo check karti hai ki saare App Services chal rahe hain ya nahi — green matlab sahi, red matlab problem!

```powershell
$apps = Get-AzWebApp | Where-Object { $_.Name -like "*bankinventory*" }

foreach ($app in $apps) {
    if ($app.State -eq "Running") {
        Write-Host "✅ $($app.Name) is Running!" -ForegroundColor Green
    } else {
        Write-Host "❌ $($app.Name) is NOT Running!" -ForegroundColor Red
    }
}
```

**Output:**
```
✅ bankinventory-dev is Running!
✅ bankinventory-prod is Running!
✅ bankinventory-staging is Running!
```

> 💡 `-ForegroundColor Green/Red` → text ka color change karna
> 💡 `$($app.Name)` → variable ke andar variable use karna

---

## 📌 Quick Reference — Day 1 Cheat Sheet

| Concept | PowerShell | Matlab |
|---------|-----------|--------|
| Variable | `$name = "value"` | Value store karna |
| Print | `Write-Host "text"` | Screen pe dikhana |
| Equal check | `-eq` | == jaisa |
| Contains check | `-like "*text*"` | Mein hai ya nahi |
| Array | `@("a", "b", "c")` | List banana |
| Loop | `foreach ($x in $arr)` | Har item pe kaam |
| Filter | `Where-Object { $_.Name -eq "x" }` | Sirf yeh dikhao |
| Pipe | `cmd1 \| cmd2` | Output pass karna |
| Current item | `$_` | Abhi wali cheez |
| Color output | `-ForegroundColor Green` | Colored text |

---

*Day 1 Complete! ✅ — PowerShell Basics + Azure Resource Management*