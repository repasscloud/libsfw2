<# LOAD FUNCTIONS #>
[System.String[]]$Functions = "Export-JsonManifest.ps1","Get-AbsoluteUri.ps1","New-GitHubIssue.ps1","New-VirusTotalScan.ps1","Invoke-OXAppIngest.ps1","Install-ApplicationPackage.ps1","Uninstall-ApplicationPackage.ps1"
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
    -DisplayPublisher $adr_displaypublisher `
    -DisplayVersion $adr_displayversion `
    -DetectMethod $adr_detectmethod `
    -UninstallProcess $adr_uninstallprocess `
    -UninstallCmd $adr_uninstallcmd `
    -UninstallArgs $adr_uninstallargs `
    -RebootRequired $adr_rebootrequired `
    -XFT $adr_xft `
    -Locale $adr_locale `
    -OutPath $PSScriptRoot `
    -NuspecUri $adr_nuspec    
}

Get-ChildItem -Path $env:APPVEYOR_BUILD_FOLDER -Filter "*.json" -File -Recurse | ForEach-Object {
    $_.FullName
    #Invoke-OXAppIngest -BaseUri $env:API_BASE_URI -JsonPayload $_.FullName
}
