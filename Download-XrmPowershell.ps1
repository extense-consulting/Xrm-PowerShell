Install-PackageProvider nuget -force
Write-Output "Installing Microsoft.Xrm.Data.Powershell"
Import-Module Microsoft.Xrm.Data.Powershell -Verbose -RequiredVersion 2.8.0
Write-Output "Installing Microsoft.Xrm.Data.PowerShell"
Install-Module Microsoft.Xrm.Data.PowerShell -Scope CurrentUser -Force -RequiredVersion 2.8.0