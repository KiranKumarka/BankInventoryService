function Get-InventoryAppHealth {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)]
        [string]$AppName
    )

    Process {
        try {
            $app = Get-AzWebApp -Name $AppName -ErrorAction Stop
            Write-Host "✅ $AppName is $($app.State)" -ForegroundColor Green
        }
        catch {
            Write-Host "❌ Error: $($_.Exception.Message)" -ForegroundColor Red
        }

        "$AppName status was checked at $(Get-Date)" | Out-File -FilePath ".\Scripts\log.txt" -Append
    }
}

# Clean up script after deployment

function Clear-AppTemp {
    Write-Host "🧹 Cleaning Temp files for Deployment..." -ForegroundColor Yellow
    Remove-Item -Path ".\bin\*", ".\obj\*" -Recurse -ErrorAction SilentlyContinue
    Write-Host "✅ Cleanup Done!" -ForegroundColor Green
}