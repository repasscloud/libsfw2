# HKLM Paths
[System.Array]$hklmPaths = @(
    "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall",
    "HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall"
)

# Export data to CSV dump file
Get-ChildItem -Path $hklmPaths | Get-ItemProperty | Where-Object -FilterScript {$null -notlike $_.DisplayName} | Export-Csv -Path "$env:TMP\CSV_PRE-INSTALL_DUMP.csv" -NoTypeInformation 
