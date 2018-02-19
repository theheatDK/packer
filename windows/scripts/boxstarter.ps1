Write-Output ""
Write-Output "###############################################################################"
Write-Output "Download bootstrapper.ps1"
Write-Output "###############################################################################"
iex ((new-object net.webclient).DownloadString('https://raw.githubusercontent.com/mwrock/boxstarter/master/BuildScripts/bootstrapper.ps1'))

Write-Output ""
Write-Output "###############################################################################"
Write-Output "Get-Boxstarter"
Write-Output "###############################################################################"
Get-Boxstarter -Force

Write-Output ""
Write-Output "###############################################################################"
Write-Output "Import-Module boxstarter.chocolatey.psd1"
Write-Output "###############################################################################"
#Import-Module $env:appdata\boxstarter\boxstarter.chocolatey\boxstarter.chocolatey.psd1
Import-Module -Name "C:\Users\All Users\Boxstarter\Boxstarter.Chocolatey\boxstarter.chocolatey.psd1"

Write-Output ""
Write-Output "###############################################################################"
Write-Output "Install-BoxstarterPackage"
Write-Output "###############################################################################"
$secpasswd = ConvertTo-SecureString "packer" -AsPlainText -Force
$cred      = New-Object System.Management.Automation.PSCredential ("packer", $secpasswd)
Install-BoxstarterPackage -PackageName https://gist.githubusercontent.com/theheatDK/c8ffd36caa02d8b3fff6a1b90fbdb6b3/raw/862ab0b3dc622a1a4f2ed3cdbf60a877760b57ea/Windows-10-boxstarter.ps1 -Credential $cred -Verbose
