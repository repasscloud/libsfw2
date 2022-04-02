[System.Array]$hklmPaths = @(
    "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall",
    "HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall"
)

foreach ($Path in $hklmPaths)
{
    Get-ChildItem -Path $Path | Get-ItemProperty | Where-Object -FilterScript {$null -notlike $_.DisplayName} | Select-Object -Property Publisher,DisplayName,DisplayVersion | Export-Csv -Path C:\Projects\libsfw2\public\installed_report.csv -NoTypeInformation
}


$Count = (Import-Csv -Path C:\Projects\libsfw2\public\installed_report.csv).Count
Write-Output "installed application in store-regdata is: ${Count}"
