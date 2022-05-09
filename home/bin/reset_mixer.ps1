if (!(new-object System.Security.Principal.WindowsPrincipal([System.Security.Principal.WindowsIdentity]::GetCurrent())).IsInRole([System.Security.Principal.WindowsBuiltInRole]::Administrator)) {
    $elevated = new-object System.Diagnostics.ProcessStartInfo 'PowerShell'
    $elevated.Arguments = $myInvocation.MyCommand.Definition
    $elevated.Verb = 'runas'
    $null = [System.Diagnostics.Process]::Start($elevated)
    return
}

function Write-Status {
	if ($args[0]) {
		Write-Host -ForegroundColor Green "OK"
	} else {
		Write-Host -ForegroundColor Red "ERR"
	}
}

Write-Host -NoNewline 'Stopping Audiosrv... '
Stop-Service -Name Audiosrv -Force
Write-Status $?

Write-Host -NoNewline 'Stopping AudioEndpointBuilder... '
Stop-Service -Name AudioEndpointBuilder -Force
Write-Status $?

Write-Host -NoNewline 'Deleting PropertyStore in Registry... '
Remove-Item -Path 'HKCU:Software\Microsoft\Internet Explorer\LowRegistry\Audio\PolicyConfig\PropertyStore' -Force -Recurse
Write-Status $?

Write-Host -NoNewline 'Creating PropertyStore in Registry... '
$null = New-Item -Path 'HKCU:Software\Microsoft\Internet Explorer\LowRegistry\Audio\PolicyConfig\' -Name PropertyStore
Write-Status $?

Write-Host -NoNewline 'Starting Audiosrv... '
Start-Service -Name Audiosrv
Write-Status $?

Sleep -Seconds 5