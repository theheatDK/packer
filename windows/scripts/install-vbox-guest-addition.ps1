$iso_path = "C:\temp\VBoxGuestAdditions.iso"
Write-Output "Mounting disk image at $iso_path"
Mount-DiskImage -ImagePath $iso_path

$cert_dir = ((Get-DiskImage -ImagePath $iso_path | Get-Volume).Driveletter + ':\cert\')
$VBoxCertUtil = ($cert_dir + 'VBoxCertUtil.exe')
Write-Output "Import certificates"
Get-ChildItem $cert_dir *.cer | ForEach-Object { & $VBoxCertUtil add-trusted-publisher $_.FullName --root $_.FullName}

$exe = ((Get-DiskImage -ImagePath $iso_path | Get-Volume).Driveletter + ':\VBoxWindowsAdditions.exe')
$parameters = '/S'

Write-Output "Run VBoxWindowsAdditions.exe"
Start-Process $exe $parameters -Wait

Write-Output "Dismounting disk image $iso_path"
Dismount-DiskImage -ImagePath $iso_path
Write-Output "Deleting $iso_path"
Remove-Item $iso_path