Param(
    [string] $crmUser,
    [string] $crmPassword,
    [string] $crmUrl,
    [int] $timeOut,
    [string] $outputDir,
    [string] $crmSolution,
	[string] $crmOrganizationName,
	[bool] $managed,
	[bool] $unmanaged
)

Write-Output "Logging in as $crmUser with password $crmPassword"
$securePwd = ConvertTo-SecureString $crmPassword -AsPlainText -Force
$crmCredential = New-Object System.Management.Automation.PSCredential($crmUser,$securePwd)

Write-Output "Connecting to CRM"
$crmConnection = Get-CrmConnection -ServerUrl $crmUrl -OrganizationName $crmOrganizationName -Verbose -Credential $crmCredential -MaxCrmConnectionTimeOutMinutes $timeOut

Write-Output "Export CRM Solution $crmSolution to directory $outputDir"

if($managed) {
Export-CrmSolution -conn $crmConnection -SolutionName $crmSolution -SolutionFilePath $outputDir -SolutionZipFileName "$($crmSolution)_managed.zip" -Managed -Verbose -ExportAutoNumberingSettings -ExportCalendarSettings -ExportCustomizationSettings -ExportEmailTrackingSettings -ExportGeneralSettings -ExportMarketingSettings -ExportOutlookSynchronizationSettings -ExportRelationshipRoles -ExportIsvConfig -ExportSales
}

if($unmanaged) {
Export-CrmSolution -conn $crmConnection -SolutionName $crmSolution -SolutionFilePath $outputDir -SolutionZipFileName "$($crmSolution)_unmanaged.zip" -ExportAutoNumberingSettings -ExportCalendarSettings -ExportCustomizationSettings -ExportEmailTrackingSettings -ExportGeneralSettings -ExportMarketingSettings -ExportOutlookSynchronizationSettings -ExportRelationshipRoles -ExportIsvConfig -ExportSales -Verbose
}