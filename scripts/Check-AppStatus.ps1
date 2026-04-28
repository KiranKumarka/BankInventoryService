function Get-InventoryAppHealth {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)]
        [string]$AppName
    )

    Process {
        Write-Host "🔍 Checking status for: $AppName..." -ForegroundColor Cyan
        
        try {
            # Check if Azure connection exists
            $app = Get-AzWebApp -Name $AppName -ErrorAction Stop
            
            if ($app.State -eq "Running") {
                Write-Host "✅ [HEALTHY] $AppName is UP and running." -ForegroundColor Green
            } else {
                Write-Host "⚠️ [WARNING] $AppName is in $($app.State) state." -ForegroundColor Yellow
            }
        }
        catch {
            Write-Host "❌ [ERROR] Could not find or access App: $AppName. Check your login/permissions." -ForegroundColor Red
            Write-Host "Details: $($_.Exception.Message)" -ForegroundColor Gray
        }
    }
}