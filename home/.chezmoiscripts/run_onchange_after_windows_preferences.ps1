# Re-execute as admin if we're not already elevated.
if (-not ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    $Args = "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`""
    (Start-Process PowerShell -Verb RunAs -ArgumentList $Args -Passthru).WaitForExit()
    return
}

# Set my shell preferences.
Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced' -Name Hidden -Value 1
Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced' -Name HideFileExt -Value 0
Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced' -Name ShowSuperHidden -Value 0
Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced' -Name HideDrivesWithNoMedia -Value 1
Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced' -Name NavPaneExpandToCurrentFolder -Value 0
Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced' -Name NavPaneShowAllFolders -Value 0
Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced' -Name LaunchTo -Value 1
Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced' -Name MMTaskbarMode -Value 2

# Add 'Reboot into UEFI Firmware' to the Desktop context menu.
$UEFIMenu = 'HKLM:\Software\Classes\DesktopBackground\Shell\UEFI'
if (!(Test-Path -Path $UEFIMenu)) {
    Write-Host 'Adding "Reboot into UEFI Firmware" to Desktop context menu...'
    $null = New-Item -Path "$UEFIMenu\command" -ItemType Directory -Force
}
Set-ItemProperty -Path $UEFIMenu -Name 'Icon' -Value 'bootux.dll,-1016'
Set-ItemProperty -Path $UEFIMenu -Name 'MUIVerb' -Value 'Reboot into UEFI Firmware'
Set-ItemProperty -Path $UEFIMenu -Name 'Position' -Value 'Bottom'
Set-ItemProperty -Path $UEFIMenu -Name 'HasLUAShield' -Value ''
Set-Item -Path "$UEFIMenu\command" -Value "shutdown.exe /r /fw /f /t 0"

# Add %USERPROFILE%\bin to the PATH.
$bin = "$env:USERPROFILE\bin"
$path = [Environment]::GetEnvironmentVariable('PATH', 'User').Split(';')
if (!$path.Contains($bin)) {
    Write-Host "Adding $bin to PATH"
    $path = [String]::Join(';', $path + $PSScriptRoot)
    [Environment]::SetEnvironmentVariable('PATH', $path, 'User')
}

# Add my standard variables to WSLENV.
foreach ($var in @('APPDATA/p', 'LOCALAPPDATA/p', 'USERPROFILE/p', 'TERMINAL_EMULATOR')) {
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

# Activate developer mode.
$DevMode = 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\AppModelUnlock'
if (!(Test-Path -Path $DevMode)) {
    Write-Host 'Enabling Developer Mode...'
    $null = New-Item -Path $DevMode -ItemType Directory -Force
}
Set-ItemProperty -Path $DevMode -Name AllowDevelopmentWithoutDevLicense -Value 1

# Enable WSL/Hyper-V.
wsl --status
if ($LASTEXITCODE -ne 0) {
    Write-Host 'Installing WSL...'
    wsl --install --distribution archlinux
}
if (!(Get-WindowsOptionalFeature -Online -FeatureName Microsoft-Hyper-V-All).State) {
    Write-Host 'Enabling Hyper-V...'
    Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Hyper-V-All
}
