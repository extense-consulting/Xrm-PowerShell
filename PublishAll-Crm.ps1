Param(
    [string]$crmUser,
    [string]$crmPassword,
    [string]$crmUrl,
    [int]$timeOut,
	[string]$crmOrganizationName
)

Write-Output "Logging in as $crmUser with password $crmPassword"
$securePwd = ConvertTo-SecureString $crmPassword -AsPlainText -Force
$crmCredential = New-Object System.Management.Automation.PSCredential($crmUser, $securePwd)

Write-Output "Connecting to CRM"
$crmConnection = Get-CrmConnection -ServerUrl $crmUrl -OrganizationName $crmOrganizationName -Verbose -Credential $crmCredential -MaxCrmConnectionTimeOutMinutes $timeOut

Write-Output "Publish all customizations"
Publish-CrmAllCustomization -conn $crmConnection -Verbose