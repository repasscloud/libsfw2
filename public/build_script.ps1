<# LOAD FUNCTIONS #>
[System.String[]]$Functions = "Export-JsonManifest.ps1","Get-AbsoluteUri.ps1","New-GitHubIssue.ps1","New-VirusTotalScan.ps1","Invoke-OptechXApplicationIngest.ps1"
foreach ($function in $Functions)
{
  Get-ChildItem -Path $env:APPVEYOR_BUILD_FOLDER\libsfw-ps -Filter "${function}" -File | ForEach-Object { . $_.FullName }
}

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
}

Get-ChildItem -Path $env:APPVEYOR_BUILD_FOLDER -Filter "*.json" -File -Recurse | ForEach-Object {
    #Invoke-OXAppIngest -BaseUri $env:API_BASE_URI -JsonPayload $_.FullName
}
