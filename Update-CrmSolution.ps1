Param(
    [string]$crmUser,
    [string]$crmPassword,
    [string]$crmUrl,
    [int]$timeOut,
    [string]$crmSolution,
    [string]$crmSolutionVersion,
	[string]$crmOrganizationName
)

Write-Output "Logging in as $crmUser with password $crmPassword"
$securePwd = ConvertTo-SecureString $crmPassword -AsPlainText -Force
$crmCredential = New-Object System.Management.Automation.PSCredential($crmUser, $securePwd)

Write-Output "Connecting to CRM"
$crmConnection = Get-CrmConnection -ServerUrl $crmUrl -OrganizationName $crmOrganizationName -Verbose -Credential $crmCredential -MaxCrmConnectionTimeOutMinutes $timeOut

Write-Output "Updating CRM Solution version for $crmSolution to version $crmSolutionVersion"
$solutionQuery = Get-CrmRecords -conn $crmConnection -EntityLogicalName "solution" -FilterAttribute "uniquename" -FilterOperator "eq" -FilterValue $crmSolution -Fields "version"
$solutionId = $solutionQuery.CrmRecords[0].solutionid
$solutionRecord = Get-CrmRecord -conn $crmConnection -EntityLogicalName "solution" -Id $solutionId -Fields "version"
$solutionRecord.version = $crmSolutionVersion
Set-CrmRecord -conn $crmConnection $solutionRecord -Verbose