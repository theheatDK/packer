Write-Output ""
Write-Output "###############################################################################"
Write-Output "Set networks to private"
Write-Output "###############################################################################"
$networkListManager = [Activator]::CreateInstance([Type]::GetTypeFromCLSID([Guid]"{DCB00C01-570F-4A9B-8D69-199FDBA5723B}"))
$connections = $networkListManager.GetNetworkConnections()
$connections |foreach {
	Write-Output $_.GetNetwork().GetName()"category was previously set to"$_.GetNetwork().GetCategory()
	$_.GetNetwork().SetCategory(1)
	Write-Output $_.GetNetwork().GetName()"changed to category"$_.GetNetwork().GetCategory()
}

Write-Output ""
Write-Output "###############################################################################"
Write-Output "Configure WinRM"
Write-Output "###############################################################################"
Enable-PSRemoting
winrm set winrm/config/client/auth '@{Basic="true"}'
winrm set winrm/config/service/auth '@{Basic="true"}'
winrm set winrm/config/service '@{AllowUnencrypted="true"}'
Restart-Service -Name WinRM
