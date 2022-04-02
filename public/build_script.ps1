<# LOAD FUNCTIONS #>
[System.String[]]$Functions = "Export-JsonManifest.ps1","Get-AbsoluteUri.ps1","New-GitHubIssue.ps1","New-VirusTotalScan.ps1","Invoke-OptechXApplicationIngest.ps1"
foreach ($function in $Functions)
{
  Get-ChildItem -Path $env:APPVEYOR_BUILD_FOLDER\libsfw-ps -Filter "${function}" -File | ForEach-Object { . $_.FullName }
}

<# CORELIB VARIABLES #>
[System.Array]$hklmPaths = @(
  "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall",
  "HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall"
)

<# SOURCE CORELIB FILES #>
[System.String[]]$SourceFiles = Get-ChildItem -Path .\data\corelib\ -Filter "*.ps1" -File -Recurse | Select-Object -ExpandProperty FullName
foreach ($sf in $SourceFiles)
{
    <# DOT SOURCE FILE #>
    . $sf

    <# GENERATE JSON MANIFEST #>
    Export-JsonManifest -Category $adr_category `
      -Publisher $adr_publisher `
      -Name $adr_name `
      -Version $adr_version `
      -Copyright $adr_copyright `
      -LicenseAcceptRequired $adr_licenseacceptrequired `
      -LCID $adr_lcid `
      -Arch $adr_arch `
      -FollowUri $adr_followuri `
      -AbsoluteUri $adr_absoluteuri `
      -ExecType $adr_exectype `
      -InstallCmd $adr_installcmd `
      -InstallArgs $adr_installargs `
      -DisplayName $adr_displayname `
      -DetectMethod $adr_detectmethod `
      -UninstallProcess $adr_uninstallprocess `
      -UninstallArgs $adr_uninstallargs `
      -RebootRequired $adr_rebootrequired `
      -XFT $adr_xft `
      -Locale $adr_locale `
      -OutPath $PSScriptRoot `
      -NuspecUri $adr_nuspec
    
      $JsonData = Get-Content -Path C:\Projects\libsfw2\public\adobe_acrobatreaderdc_22.001.20085_x64_exe_MUI.json | ConvertFrom-Json
      $JsonData.install.displayname
    
      "installing adobe"
      Start-Process -FilePath "$env:TMP\$($JsonData.meta.filename)" -ArgumentList "'$($JsonData.install.installswitches)'" -Wait

    
}

# HKLM Paths
[System.Array]$hklmPaths = @(
    "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall",
    "HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall"
)

Get-ChildItem -Path $hklmPaths | Get-ItemProperty | Where-Object -FilterScript {$null -notlike $_.DisplayName} | Export-Csv -Path C:\Projects\libsfw2\regdata-after-finish.csv -NoTypeInformation 





Get-ChildItem -Path $env:APPVEYOR_BUILD_FOLDER -Filter "*.json" -File -Recurse | ForEach-Object {
    #Invoke-OXAppIngest -BaseUri $env:API_BASE_URI -JsonPayload $_.FullName
}


# $AlreadyInstalled = Import-Csv -Path C:\Projects\libsfw2\public\installed_report.csv
# if ($AlreadyInstalled.Count -eq 957)
# {
#   $JsonData = Get-Content -Path C:\Projects\libsfw2\public\adobe_acrobatreaderdc_22.001.20085_x64_exe_MUI.json | ConvertFrom-Json
#   $JsonData.install.displayname

#   "installing adobe"
#   Start-Process -FilePath "$env:TMP\$($JsonData.meta.filename)" -ArgumentList "'$($JsonData.install.installswitches)'" -Wait
# }










# [System.Array]$hklmPaths = @(
#   "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall",
#   "HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall"
# )

# foreach ($Path in $hklmPaths)
# {
#   Get-ChildItem -Path $Path | Get-ItemProperty | Where-Object -FilterScript {$null -notlike $_.DisplayName} | Select-Object -Property Publisher,DisplayName,DisplayVersion | Export-Csv -Path C:\Projects\libsfw2\public\installed_report2.csv -NoTypeInformation
# } 

# $NewlyChecked = Import-Csv -Path C:\Projects\libsfw2\public\installed_report2.csv

# $NewlyChecked.Count
