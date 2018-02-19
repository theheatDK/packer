$iso_path = "C:\temp\VBoxGuestAdditions.iso"

Write-Output ""
Write-Output "###############################################################################"
Write-Output "Mounting disk image at $iso_path"
Write-Output "###############################################################################"
Mount-DiskImage -ImagePath $iso_path

$cert_dir = ((Get-DiskImage -ImagePath $iso_path | Get-Volume).Driveletter + ':\cert\')
$VBoxCertUtil = ($cert_dir + 'VBoxCertUtil.exe')
Write-Output ""
Write-Output "###############################################################################"
Write-Output "Importing certificates"
Write-Output "###############################################################################"
Get-ChildItem $cert_dir *.cer | ForEach-Object { & $VBoxCertUtil add-trusted-publisher $_.FullName --root $_.FullName}
$exe = ((Get-DiskImage -ImagePath $iso_path | Get-Volume).Driveletter + ':\VBoxWindowsAdditions.exe')
$parameters = '/S'

Write-Output ""
Write-Output "###############################################################################"
Write-Output "Running VBoxWindowsAdditions.exe"
Write-Output "###############################################################################"
Start-Process $exe $parameters -Wait

Write-Output ""
Write-Output "###############################################################################"
Write-Output "Dismounting disk image $iso_path"
Write-Output "###############################################################################"
Dismount-DiskImage -ImagePath $iso_path

Write-Output ""
Write-Output "###############################################################################"
Write-Output "Deleting $iso_path"
Write-Output "###############################################################################"
Remove-Item $iso_path