<# SET VARIABLES #>
[System.String]$ProjectRoot = Split-Path -Path $PSScriptRoot -Parent

<# LOAD FUNCTIONS #>
[System.Array]$Functions = @("Get-AbsoluteUri.ps1","New-ApplicationObject.ps1","Get-RedirectedUri.ps1")
foreach ($Function in $Functions)
{
    Get-ChildItem -Path "${ProjectRoot}\libsfw-ps" -Filter "${Function}" -File | ForEach-Object { . $_.FullName }
}

<# SOURCE CORELIB FILES #>
[System.String[]]$SourceFiles = Get-ChildItem -Path "${ProjectRoot}\data\corelib\" -Filter "*.ps1" -File -Recurse | Select-Object -ExpandProperty FullName
foreach ($sf in $SourceFiles)
{
    <# DOT SOURCE FILE #>
    . $sf

    $adr_followuri

    <# VERIFY FOLLOW URI AND ABSOLUTE URI BEFORE INJECT #>
    if ((Get-RedirectedUri -Uri $adr_followuri) -notlike "INVALID")
    {
        "IT'S NOT FISHY"
    }

}
