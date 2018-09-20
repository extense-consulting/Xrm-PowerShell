<#

.SYNOPSIS
This script imports Solution Packages to Dynamics 365.

.DESCRIPTION
This script requires parameters to operate properly. The following parameters are required:
-crmUser = user@domain.extension
-crmPassword = P@ssw0rd
-crmUrl = http://servername/organization
-crmOrganizationName = organization
-timeOut = 30
-packageFileName = package.dll
-packageDirectory = C:\directory\

.LINK
https://technet.microsoft.com/nl-nl/library/dn756301.aspx

#>
Param(
    [string]$crmUser,
    [string]$crmPassword,
    [string]$crmUrl,
	[string]$crmOrganizationName,
	[int]$timeOut,
    [string]$packageFileName,
    [string]$packageDirectory
)

Set-Location $packageDirectory #$(System.DefaultWorkingDirectory)/Quartz-Daily/CRMPackage/

Import-Module Microsoft.Xrm.Data.Powershell -Verbose
Install-Module Microsoft.Xrm.Data.PowerShell -Scope CurrentUser -Force -Verbose

$toolingConnector = ".\PowerShell\Microsoft.Xrm.Tooling.CrmConnector.Powershell.dll"
$toolingDeployment = ".\PowerShell\Microsoft.Xrm.Tooling.PackageDeployment.Powershell.dll"

Import-Module $toolingConnector -Verbose
Import-Module $toolingDeployment -Verbose

$packageDirectory = Resolve-Path ".\"
$securePwd = ConvertTo-SecureString $crmPassword -AsPlainText -Force
$crmCredential = New-Object System.Management.Automation.PSCredential($crmUser, $securePwd)

$crmConnection = Get-CrmConnection -ServerUrl $crmUrl -OrganizationName $crmOrganizationName -Verbose -Credential $crmCredential -MaxCrmConnectionTimeOutMinutes $timeOut

Import-CrmPackage –CrmConnection $crmConnection –PackageDirectory $packageDirectory –PackageName $packageFileName -Timeout $timeOut -Verbose –UnpackFilesDirectory ".\Unpack\" -LogWriteDirectory ".\Logs\"
