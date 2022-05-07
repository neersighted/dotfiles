if (!(new-object System.Security.Principal.WindowsPrincipal([System.Security.Principal.WindowsIdentity]::GetCurrent())).IsInRole([System.Security.Principal.WindowsBuiltInRole]::Administrator)) {
    $elevated = new-object System.Diagnostics.ProcessStartInfo 'PowerShell'
    $elevated.Arguments = $myInvocation.MyCommand.Definition
    $elevated.Verb = 'runas'
    $null = [System.Diagnostics.Process]::Start($elevated)
    return
}

# We must manually create the HKCD: drive.
New-PSDrive -PSProvider registry -Root HKEY_CLASSES_ROOT -Name HKCR

$AppModelUnlock = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\AppModelUnlock"
if (!(Test-Path -Path $AppModelUnlock)) {
    Write-Host 'Enabling Developer Mode...'
    $null = New-Item -Path $AppModelUnlock -ItemType Directory -Force
}
Set-ItemProperty -Path $AppModelUnlock -Name AllowDevelopmentWithoutDevLicense -Value 1

$UEFIMenu = "HKCR:\DesktopBackground\Shell\UEFI"
if (!(Test-Path -Path $UEFIMenu)) {
    Write-Host 'Adding "Reboot into UEFI Firmware" to the Desktop context menu...'
    $null = New-Item -Path $UEFIMenu -ItemType Directory -Force
    $null = New-Item -Path $UEFIMenu'\command' -ItemType Directory -Force
}
Set-ItemProperty -Path $UEFIMenu -Name Icon -Value "bootux.dll,-1016"
Set-ItemProperty -Path $UEFIMenu -Name MUIVerb -Value "Reboot into UEFI Firmware"
Set-ItemProperty -Path $UEFIMenu -Name Position -Value "Bottom"
Set-ItemProperty -Path $UEFIMenu'\command' -Name '(Default)' -Value "powershell -WindowStyle Hidden -NoProfile -Command `"Start-Process shutdown -ArgumentList '/r /f /t 0 /fw' -Verb runAs`""

Write-Host 'Setting up Explorer/Shell preferences...'
Set-ItemProperty -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\CabinetState -Name FullPath -Value 1
Set-ItemProperty -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced -Name Hidden -Value 1
Set-ItemProperty -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced -Name HideFileExt -Value 0
Set-ItemProperty -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced -Name ShowSuperHidden -Value 0
Set-ItemProperty -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced -Name HideDrivesWithNoMedia -Value 1
Set-ItemProperty -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced -Name NavPaneExpandToCurrentFolder -Value 0
Set-ItemProperty -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced -Name NavPaneShowAllFolders -Value 1
Set-ItemProperty -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced -Name LaunchTo -Value 1
Set-ItemProperty -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced -Name MMTaskbarMode -Value 2

$path = [Environment]::GetEnvironmentVariable('PATH', 'User').Split(';')
if (!$path.Contains($PSScriptRoot)) {
    Write-Host "Adding $PSScriptRoot to PATH"
    $path = [String]::Join(';', $path + $PSScriptRoot)
    [Environment]::SetEnvironmentVariable('PATH', $path, 'User')
}

foreach ($var in @("APPDATA/p", "LOCALAPPDATA/p", "USERPROFILE/p", "TERMINAL_EMULATOR")) {
    $wslenv = [Environment]::GetEnvironmentVariable('WSLENV', 'User')
    if ($wslenv) {
        $wslenv = $wslenv.Split(':')
    } else {
        $wslenv = @()
    }

    if (!$wslenv.Contains($var)) {
        Write-Host "Adding $var to WSLENV"
        $wslenv = [String]::Join(':', $wslenv + $var)
        [Environment]::SetEnvironmentVariable('WSLENV', $wslenv, 'User')
    }
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
