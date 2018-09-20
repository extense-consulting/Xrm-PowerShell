Param(
    [string]$crmUser,
    [string]$crmPassword,
    [string]$crmUrl,
	[string]$crmOrganizationName,
	[int]$timeOut,
    [string]$solutionFilePath,
    [string]$solutionUniqueName
)
Write-Output "Logging in as $crmUser with password $crmPassword"

$securePwd = ConvertTo-SecureString $crmPassword -AsPlainText -Force
$crmCredential = New-Object System.Management.Automation.PSCredential($crmUser, $securePwd)

Write-Output "Connecting to CRM"
$crmConnection = Get-CrmConnection -ServerUrl $crmUrl -OrganizationName $crmOrganizationName -Verbose -Credential $crmCredential -MaxCrmConnectionTimeOutMinutes $timeOut

[int]$timeOutMinutes = $timeOut*60

Write-Output "Importing file $solutionFilePath"
Import-CrmSolution -SolutionFilePath $solutionFilePath -ActivatePlugIns -OverwriteUnManagedCustomizations -ImportAsHoldingSolution -PublishChanges -conn $crmConnection -Verbose -Debug -MaxWaitTimeInSeconds $timeOutMinutes

$UpgradeSolutionRequest = new-object Microsoft.Crm.Sdk.Messages.DeleteAndPromoteRequest
$UpgradeSolutionRequest.UniqueName = $solutionUniqueName
$response = $crmConnection.ExecuteCrmOrganizationRequest($UpgradeSolutionRequest)

#the unique identifier of the promoted solution
write-output $response.SolutionId