# install optechx.DownloadFile.dll (odf)
dotnet restore C:\Projects\optechx.DownloadFile\optechx.DownloadFile\optechx.DownloadFile.csproj
msbuild C:\Projects\optechx.DownloadFile\optechx.DownloadFile.sln /verbosity:minimal /logger:"C:\Program Files\AppVeyor\BuildAgent\Appveyor.MSBuildLogger.dll" /property:Configuration=Release
New-Item -Path C:\odf -ItemType Directory -Confirm:$false -Force
Copy-Item -Path C:\Projects\optechx.DownloadFile\optechx.DownloadFile\bin\Release\netcoreapp2.2\* -Destination C:\odf\ -Recurse -Confirm:$false -Force

# minio/mc configuration
Write-Output "$([System.Char]::ConvertFromUTF32("0x1F7E1")) CREATE DIRECTORY: 'C:\mc'"
New-Item -Path C:\mc\bin -ItemType Directory -Force -Confirm:$false | Out-Null
Write-Output "$([System.Char]::ConvertFromUTF32("0x1F7E1")) UPDATE ENV:PATH"
$env:PATH += ';C:\mc\bin'
Invoke-WebRequest -Uri 'https://dl.min.io/client/mc/release/windows-amd64/mc.exe' -OutFile 'C:\mc\bin\mc.exe' -UseBasicParsing
mc alias set upcloud_au_syd_07 $env:MC_URI_UPCLOUD_AU_SYD_07 $env:MC_AK_UPCLOUD_AU_SYD_07 $env:MC_SK_UPCLOUD_AU_SYD_07
