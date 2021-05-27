$PSDefaultParameterValues = @{ '*:Encoding' = 'utf8' }
function prompt { "PS $pwd>" }

if (!(Get-Module -ListAvailable -Name posh-git)) 
{
    Install-Module posh-git
}
Import-Module posh-git
if (!(Get-Module -ListAvailable -Name oh-my-posh))
{
    Install-Module oh-my-posh
}
Import-Module oh-my-posh
Set-PoshPrompt -Theme ys

# Shows navigable menu of all options when hitting Tab
Set-PSReadlineKeyHandler -Key Tab -Function MenuComplete

# Autocompletion for arrow keys
Set-PSReadlineKeyHandler -Key UpArrow -Function HistorySearchBackward
Set-PSReadlineKeyHandler -Key DownArrow -Function HistorySearchForward

Set-Alias -Name admin -Value "$HOME\admin.ps1"
Set-Alias -Name bs -Value "$HOME\bs.ps1"
Set-Alias -Name open -Value Invoke-Item
Set-Alias -Name pass -Value $(Get-Command gopass).Source