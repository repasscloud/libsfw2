[System.Array]$hklmPaths = @(
    "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall",
    "HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall"
)

foreach ($Path in $hklmPaths)
{
    Get-ChildItem -Path $Path | Get-ItemProperty | Where-Object -FilterScript {$null -notlike $_.DisplayName} | Select-Object -Property Publisher,DisplayName,DisplayVersion | Export-Csv -Path C:\Projects\libsfw2\public\installed_report.csv -NoTypeInformation
}
foreach ($Path in $hklmPaths)
{
    Get-ChildItem -Path $Path | Get-ItemProperty | Where-Object -FilterScript {$_.DisplayName -like "*Adobe*"} | Select-Object -Property Publisher,DisplayName,DisplayVersion
} 

$Count = (Import-Csv -Path C:\Projects\libsfw2\public\installed_report.csv).Count
Write-Output "installed application in store-regdata is: ${Count}"



# [System.Array]$hklmPaths = @(
#     "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall",
#     "HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall"
# )

# $AlreadyInstalled = Import-Csv -Path C:\Projects\libsfw2\public\installed_report2.csv | Select-Object -ExpandProperty DisplayName
# $NewlyInstalled = @()
# foreach ($Path in $hklmPaths)
# {
# $NewlyInstalled += Get-ChildItem -Path $Path | Get-ItemProperty | Where-Object -FilterScript {$null -notlike $_.DisplayName} | Select-Object -ExpandProperty DisplayName
# } 


# # Where-Object -FilterScript {$AlreadyInstalled -notcontains $_.DisplayName}


# $AlreadyInstalled -notcontains 'Adobe AcroBat DC (64-bit)'

# foreach ($Installed in $NewlyInstalled)
# {
#     if(-not($AlreadyInstalled -contains $Installed))
#     {
#         "$Installed"
#     }
# }



# $AlreadyInstalled.Count

# $NewlyInstalled.Count 
