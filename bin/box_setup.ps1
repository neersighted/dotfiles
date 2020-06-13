if (!(new-object System.Security.Principal.WindowsPrincipal([System.Security.Principal.WindowsIdentity]::GetCurrent())).IsInRole([System.Security.Principal.WindowsBuiltInRole]::Administrator)) {
    $elevated = new-object System.Diagnostics.ProcessStartInfo 'PowerShell'
    $elevated.Arguments = $myInvocation.MyCommand.Definition
    $elevated.Verb = 'runas'
    $null = [System.Diagnostics.Process]::Start($elevated)
    return
}

Write-Host 'Setting up Explorer/Shell options...'
Set-ItemProperty -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\CabinetState -Name FullPath -Value 1
Set-ItemProperty -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced -Name Hidden -Value 1
Set-ItemProperty -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced -Name HideFileExt -Value 0
Set-ItemProperty -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced -Name ShowSuperHidden -Value 0
Set-ItemProperty -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced -Name HideDrivesWithNoMedia -Value 1
Set-ItemProperty -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced -Name NavPaneExpandToCurrentFolder -Value 0
Set-ItemProperty -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced -Name NavPaneShowAllFolders -Value 1
Set-ItemProperty -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced -Name LaunchTo -Value 1
Set-ItemProperty -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced -Name MMTaskbarMode -Value 2

$null = New-Item -Path HKCU:\Software\Policies\Microsoft\Windows\Explorer -Name ShowRunAsDifferentUserInStart -Force -Value 1

$path = [Environment]::GetEnvironmentVariable('PATH', 'User').Split(';')
if (!$path.Contains($PSScriptRoot)) {
	Write-Host "Adding $PSScriptRoot to PATH"
	$path = [String]::Join(';', $path + $PSScriptRoot)
	[Environment]::SetEnvironmentVariable('PATH', $path, 'User')
}

if (!(Get-WindowsOptionalFeature -Online -FeatureName Microsoft-Hyper-V-All).State) {
	Write-Host 'Enabling Hyper-V...'
	Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Hyper-V-All
}

if (!(Get-WindowsOptionalFeature -Online -FeatureName VirtualMachinePlatform).State) {
	Write-Host 'Enabling Virtual Machine Platform...'
	Enable-WindowsOptionalFeature -Online -FeatureName VirtualMachinePlatform
}


if (!(Get-WindowsOptionalFeature -Online -FeatureName Microsoft-Windows-Subsystem-Linux).State) {
	Write-Host 'Enabling WSL...'
	Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Windows-Subsystem-Linux
}

Write-Host 'Done!'
Sleep -seconds 15
