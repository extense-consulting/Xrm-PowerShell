Install-PackageProvider nuget -force
Write-Output "Installing Microsoft.Xrm.Data.Powershell"
Import-Module Microsoft.Xrm.Data.Powershell -Verbose
Write-Output "Installing Microsoft.Xrm.Data.PowerShell"
Install-Module Microsoft.Xrm.Data.PowerShell -Scope CurrentUser -Force