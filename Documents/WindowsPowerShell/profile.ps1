if ($host.Name -eq 'ConsoleHost') {
    Import-Module PSReadLine
    Set-PSReadLineOption -EditMode Emacs
    Set-PSReadLineKeyHandler -Key Tab -Function MenuComplete

    Import-Module PSFzf
    Set-PsFzfOption -PSReadlineChordProvider 'Ctrl+o' -PSReadlineChordReverseHistory 'Ctrl+r'

    Import-Module posh-git

    if (Get-Command "zoxide" -ErrorAction SilentlyContinue) { 
        Invoke-Expression (& {
            $hook = if ($PSVersionTable.PSVersion.Major -lt 6) { 'prompt' } else { 'pwd' }
            (zoxide init --hook $hook powershell) -join "`n"
        })
    }
}